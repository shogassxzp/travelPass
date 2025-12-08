
import Foundation
import SwiftUI
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
    
    // Поиск города по названию (через наш список координат)
    func searchCity(_ query: String) async -> [Settlement] {
        guard !query.isEmpty else { return [] }
        
        let matchingCities = CityCoordinates.cities.filter { city in
            city.name.lowercased().contains(query.lowercased())
        }
        
        return matchingCities.map { city in
            Settlement(
                title: city.name,
                code: "", // Код получим из API
                lat: city.lat,
                lng: city.lng
            )
        }
    }
    
    // Получаем станции для города
    func getStationsForCity(_ settlement: Settlement, radius: Int = 20) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Сначала получаем код города через nearest_settlement
            let nearestCity = try await networkClient.getNearestCity(
                lat: settlement.lat,
                lng: settlement.lng,
                distance: radius
            )
            
            // Теперь получаем станции вокруг города
            let stations = try await networkClient.getNearestStations(
                lat: nearestCity.lat,
                lng: nearestCity.lng,
                distance: radius
            )
            
            await MainActor.run {
                self.searchResults = stations
            }
            
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                // Если API не работает, возвращаем мок данные
                self.searchResults = self.getMockStations(for: settlement.title)
            }
        }
        
        isLoading = false
    }
    
    // Поиск рейсов между станциями
    func searchSegments(fromStationCode: String, toStationCode: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let segments = try await networkClient.searchSegments(
                from: fromStationCode,
                to: toStationCode,
                date: getCurrentDate()
            )
            
            await MainActor.run {
                self.searchSegments = segments
            }
            
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                // Возвращаем мок данные для тестирования
                self.searchSegments = self.getMockSegments()
            }
        }
        
        isLoading = false
    }
    
    // Получаем информацию о перевозчике
    func getCarrierInfo(carrierCode: String) async throws -> Carrier? {
        try await networkClient.getCarrierInfo(code: carrierCode)
    }
    
    // MARK: - Mock данные для разработки
    
    private func getMockStations(for city: String) -> [Station] {
        switch city {
        case "Москва":
            return [
                Station(
                    title: "Москва (Курский вокзал)",
                    code: "s9600213",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.756,
                    lng: 37.658,
                    distance: 0.5
                ),
                Station(
                    title: "Москва (Ленинградский вокзал)",
                    code: "s9600215",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.776,
                    lng: 37.655,
                    distance: 1.2
                ),
                Station(
                    title: "Москва (Казанский вокзал)",
                    code: "s9600217",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.774,
                    lng: 37.657,
                    distance: 1.5
                ),
                Station(
                    title: "Москва (Киевский вокзал)",
                    code: "s9600216",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.742,
                    lng: 37.565,
                    distance: 2.3
                ),
                Station(
                    title: "Москва (Ярославский вокзал)",
                    code: "s9600214",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.776,
                    lng: 37.658,
                    distance: 1.8
                )
            ]
        case "Санкт-Петербург":
            return [
                Station(
                    title: "Санкт-Петербург (Московский вокзал)",
                    code: "s9600366",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.929,
                    lng: 30.363,
                    distance: 0.3
                ),
                Station(
                    title: "Санкт-Петербург (Ладожский вокзал)",
                    code: "s9602498",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.932,
                    lng: 30.440,
                    distance: 1.1
                ),
                Station(
                    title: "Санкт-Петербург (Финляндский вокзал)",
                    code: "s9602499",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.956,
                    lng: 30.356,
                    distance: 0.8
                )
            ]
        default:
            return []
        }
    }
    
    private func getMockSegments() -> [Segment] {
        return [
            Segment(
                from: Station(
                    title: "Москва (Курский вокзал)",
                    code: "s9600213",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.756,
                    lng: 37.658,
                    distance: nil
                ),
                to: Station(
                    title: "Санкт-Петербург (Московский вокзал)",
                    code: "s9600366",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.929,
                    lng: 30.363,
                    distance: nil
                ),
                departure: "2024-01-20T22:00:00",
                arrival: "2024-01-21T06:30:00",
                thread: Thread(
                    uid: "12345",
                    title: "Сапсан",
                    number: "701",
                    carrier: Carrier(
                        code: 123,
                        title: "РЖД",
                        phone: "+7 800 775-00-00",
                        email: "info@rzd.ru",
                        url: "https://rzd.ru",
                        address: "Москва",
                        logo: nil
                    ),
                    transportType: "train"
                ),
                duration: 30600 // 8.5 часов
            ),
            Segment(
                from: Station(
                    title: "Москва (Ленинградский вокзал)",
                    code: "s9600215",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.776,
                    lng: 37.655,
                    distance: nil
                ),
                to: Station(
                    title: "Санкт-Петербург (Ладожский вокзал)",
                    code: "s9602498",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.932,
                    lng: 30.440,
                    distance: nil
                ),
                departure: "2024-01-20T23:30:00",
                arrival: "2024-01-21T08:15:00",
                thread: Thread(
                    uid: "12346",
                    title: "Ночной экспресс",
                    number: "2",
                    carrier: Carrier(
                        code: 124,
                        title: "ФПК",
                        phone: "+7 800 775-00-00",
                        email: "info@rzd.ru",
                        url: "https://rzd.ru",
                        address: "Москва",
                        logo: nil
                    ),
                    transportType: "train"
                ),
                duration: 31500 // 8.75 часов
            )
        ]
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
