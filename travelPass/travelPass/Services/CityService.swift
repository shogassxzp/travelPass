import Foundation
import Combine

@MainActor
class CityService: ObservableObject {
    private let networkClient: NetworkClient
    
    
    private var citiesCache: [String: (code: String, lat: Double, lng: Double)] = [:]
    
    private let russianCities: [(name: String, lat: Double, lng: Double)] = [
        ("Москва", 55.7558, 37.6173),
        ("Санкт-Петербург", 59.9343, 30.3351),
        ("Казань", 55.7961, 49.1064),
        ("Екатеринбург", 56.8389, 60.6057),
        ("Нижний Новгород", 56.3269, 44.0065),
        ("Новосибирск", 55.0084, 82.9357),
        ("Самара", 53.1959, 50.1002),
        ("Омск", 54.9893, 73.3682),
        ("Челябинск", 55.1644, 61.4368),
        ("Ростов-на-Дону", 47.2357, 39.7015)
    ]
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCities() async -> [Settlement] {
        print("Загрузка списка городов")
        
        var settlements: [Settlement] = []
        
        await withTaskGroup(of: Settlement?.self) { group in
            for city in russianCities {
                group.addTask {
                    do {
                        let response = try await self.networkClient.getNearestCity(
                            lat: city.lat,
                            lng: city.lng,
                            distance: 5
                        )
                        
                        await MainActor.run {
                            self.citiesCache[response.title] = (
                                code: response.code,
                                lat: response.lat,
                                lng: response.lng
                            )
                        }
                        
                        return Settlement(
                            title: response.title,
                            code: response.code,
                            lat: response.lat,
                            lng: response.lng
                        )
                    } catch {
                        return Settlement(
                            title: city.name,
                            code: "c_\(city.name)",
                            lat: city.lat,
                            lng: city.lng
                        )
                    }
                }
            }
            
            for await settlement in group {
                if let settlement = settlement {
                    settlements.append(settlement)
                }
            }
        }
        
        return settlements
    }
    
    func searchCities(by query: String) async -> [Settlement] {
        let allCities = await getCities()
        
        guard !query.isEmpty else {
            return allCities
        }
        
        return allCities.filter { city in
            city.title.lowercased().contains(query.lowercased())
        }
    }
    
    func getCityInfo(_ cityName: String) -> (code: String, lat: Double, lng: Double)? {
        return citiesCache[cityName]
    }
}
