import Combine
import Foundation

@MainActor
class StationService: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchResults: [Station] = []
    @Published var searchSegments: [Segment] = []

    private var stationsCache: [String: String] = [:]
    private var cityCoordinatesCache: [String: (lat: Double, lng: Double)] = [:]
    private let networkClient: NetworkClient
    private let cityService: CityService

    init(apiKey: String) {
        networkClient = NetworkClient(apiKey: apiKey)
        cityService = CityService(networkClient: networkClient)
    }

    // MARK: - Методы API

    func searchSegments(from: String, to: String, date: Date? = nil) async throws -> [Segment] {
        isLoading = true
        errorMessage = nil

        do {
            let fromCode = parseStationCode(from)
            let toCode = parseStationCode(to)

            let dateString: String?
            if let date = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                dateString = formatter.string(from: date)
            } else {
                dateString = nil
            }
            let segments = try await networkClient.searchSegments(
                from: fromCode,
                to: toCode,
                date: dateString
            )

            let trainSegments = segments.filter { segment in
                segment.thread.transportType.lowercased() == "train"
            }

            isLoading = false

            if trainSegments.isEmpty {
                throw APIError.noData
            }

            return segments

        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            throw error
        }
    }

    func getStationsForCity(_ cityName: String) async throws -> [Station] {
        print("🔍 Получение станций для города: \(cityName)")

        let (lat, lng) = try await getCityCoordinates(cityName)

        let stations = try await networkClient.getNearestStations(
            lat: lat,
            lng: lng,
            distance: 10
        )

        let trainStations = stations.filter { station in

            let isTrain = station.transportType?.lowercased() == "train"

            let stationType = station.stationType?.lowercased()
            let isRailwayStation = stationType == "train_station" ||
                stationType == "railway_station" ||
                stationType == "station" ||
                (station.title.lowercased().contains("вокзал"))

            let isBus = stationType == "bus_station" ||
                stationType == "bus_stop" ||
                station.title.lowercased().contains("автовокзал") ||
                station.title.lowercased().contains("автостанция")

            let isMetro = stationType == "metro_station" ||
                station.title.lowercased().contains("метро")

            return (isTrain || isRailwayStation) && !isBus && !isMetro
        }

        for station in trainStations {
            stationsCache[station.code] = station.title
        }

        print("✅ Найдено Ж/Д станций для \(cityName): \(trainStations.count)")

        return trainStations
    }

    private func getCityCoordinates(_ cityName: String) async throws -> (lat: Double, lng: Double) {
        if let coordinates = cityCoordinatesCache[cityName] {
            print("📍 Координаты города \(cityName) из кэша")
            return coordinates
        }

        // Если нет в кэше, получаем через API
        print("📍 Запрашиваем координаты города \(cityName) через API")

        // Координаты крупных городов для запроса
        let knownCityCoordinates: [String: (lat: Double, lng: Double)] = [
            "Москва": (55.7558, 37.6173),
            "Санкт-Петербург": (59.9343, 30.3351),
            "Казань": (55.7961, 49.1064),
            "Екатеринбург": (56.8389, 60.6057),
            "Нижний Новгород": (56.3269, 44.0065),
            "Новосибирск": (55.0084, 82.9357),
            "Самара": (53.1959, 50.1002),
            "Омск": (54.9893, 73.3682),
            "Челябинск": (55.1644, 61.4368),
            "Ростов-на-Дону": (47.2357, 39.7015),
        ]

        guard let coordinates = knownCityCoordinates[cityName] else {
            throw APIError.noData
        }

        cityCoordinatesCache[cityName] = coordinates

        return coordinates
    }

    func parseStationCode(_ text: String) -> String {
        print("🔍 Парсинг кода станции из: '\(text)'")
        print("📊 Размер кэша станций: \(stationsCache.count)")

        if text.contains("(") && text.contains(")") {
            let components = text.split(separator: "(")
            if components.count >= 2 {
                let stationName = String(components[1])
                    .replacingOccurrences(of: ")", with: "")
                    .trimmingCharacters(in: .whitespaces)

                print("🔍 Ищем станцию по имени: '\(stationName)'")

                // Ищем в кэше
                for (code, name) in stationsCache {
                    if name == stationName {
                        print("✅ Найдена точная станция: \(code) - \(name)")
                        return code
                    }
                }

                for (code, name) in stationsCache {
                    if name.contains(stationName) || stationName.contains(name) {
                        print("✅ Найдена частичная станция: \(code) - \(name)")
                        return code
                    }
                }
            }
        }

        for (code, name) in stationsCache {
            if text.contains(name) || name.contains(text) {
                print("✅ Найдена станция по тексту: \(code) - \(name)")
                return code
            }
        }

        print("❌ Станция не найдена в кэше, дефолт: s9600213")
        print("📋 Содержимое кэша: \(stationsCache)")
        return "s9600213"
    }

    func getCarrierInfo(carrierCode: String) async throws -> Carrier? {
        do {
            return try await networkClient.getCarrierInfo(code: carrierCode)
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
}
