import Foundation
import Combine

@MainActor
class StationService: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchResults: [Station] = []
    @Published var searchSegments: [Segment] = []
    
    private let networkClient: NetworkClient
    
    init(apiKey: String) {
        self.networkClient = NetworkClient(apiKey: apiKey)
    }
    
    //MARK: - Методы API
    
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
            isLoading = false
            return segments
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            throw error
        }
    }
    
    private func parseStationCode(_ text: String) -> String {
           // Пока просто возвращаем дефолтные значения
           // Позже реализуем полноценный парсинг
           if text.contains("Москва") {
               return "s9600213"  // Москва Курский вокзал
           } else if text.contains("Санкт-Петербург") {
               return "s9600366"  // СПб Московский вокзал
           } else if text.contains("Казань") {
               return "s9604000"  // Казань
           } else {
               return "s9600213"  // Дефолт
           }
       }
    
    func getCarrierInfo(carrierCode: String) async throws -> Carrier? {
        do {
            return try await networkClient.getCarrierInfo(code: carrierCode)
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
    
    //MARK: - Статические данные(для теста)
    
    func getMockSegments(fromCode: String, toCode: String) -> [Segment] {
        let carriers = [
            Carrier(
                code: 123,
                title: "РЖД",
                phone: "+7 800 775-00-00",
                email: "info@rzd.ru",
                url: "https://rzd.ru",
                address: "Москва",
                logo: nil
            ),
            Carrier(
                code: 124,
                title: "ФПК",
                phone: "+7 800 775-00-00",
                email: "info@rzd.ru",
                url: "https://rzd.ru",
                address: "Москва",
                logo: nil
            ),
            Carrier(
                code: 125,
                title: "Сапсан",
                phone: "+7 800 775-00-00",
                email: "info@rzd.ru",
                url: "https://rzd.ru",
                address: "Москва",
                logo: nil
            )
        ]
        
        let times = [
            ("22:00", "06:30", 30600),
            ("23:30", "08:15", 31500),
            ("07:45", "16:20", 30900),
            ("15:20", "23:45", 30300)
        ]
        
        var segments: [Segment] = []
        
        for (index, time) in times.enumerated() {
            let carrier = carriers[index % carriers.count]
            
            // Создаем станции из кодов
            let fromStation = Station(
                title: getStationName(fromCode) ?? "Станция отправления",
                code: fromCode,
                stationType: "train_station",
                transportType: "train",
                lat: nil,
                lng: nil,
                distance: nil
            )
            
            let toStation = Station(
                title: getStationName(toCode) ?? "Станция назначения",
                code: toCode,
                stationType: "train_station",
                transportType: "train",
                lat: nil,
                lng: nil,
                distance: nil
            )
            
            let segment = Segment(
                from: fromStation,
                to: toStation,
                departure: "2024-01-20T\(time.0):00",
                arrival: "2024-01-\(time.0 == "22:00" || time.0 == "23:30" ? "21" : "20")T\(time.1):00",
                thread: Thread(
                    uid: "mock_\(index)",
                    title: carrier.title == "Сапсан" ? "Сапсан" : "Поезд №\(index + 700)",
                    number: "\(700 + index)",
                    carrier: carrier,
                    transportType: "train"
                ),
                duration: time.2
            )
            
            segments.append(segment)
        }
        
        return segments
    }
    
    // Поиск городов по названию (статические данные)
        func searchCitiesStatic(_ query: String) async -> [Settlement] {
            guard !query.isEmpty else { return [] }
            
            let matchingCities = CityCoordinates.cities.filter { city in
                city.name.lowercased().contains(query.lowercased())
            }
            
            return matchingCities.map { city in
                Settlement(
                    title: city.name,
                    code: city.code,
                    lat: city.lat,
                    lng: city.lng
                )
            }
        }
        
        // Получение станций для города (статические данные)
        func getStationsForCityStatic(_ cityName: String) -> [Station] {
            return CityCoordinates.getStations(for: cityName)
        }
        
        // Получение кода станции по названию
        func getStationCode(_ stationName: String) -> String? {
            return CityCoordinates.getStationCode(for: stationName)
        }
        
        
        
        private func getStationName(_ code: String) -> String? {
            for city in CityCoordinates.cities {
                if let station = city.stations.first(where: { $0.code == code }) {
                    return station.title
                }
            }
            return nil
        }
    }
