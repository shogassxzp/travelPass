import SwiftUI
import Combine

@MainActor
class CityPickerViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var cities: [Settlement] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let stationService: StationService
    
    init(stationService: StationService) {
        self.stationService = stationService
    }
    
    func searchCities() async {
        guard !searchText.isEmpty else {
            cities = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            // Используем наш список координат для поиска городов
            let matchingCities = CityCoordinates.cities.filter { city in
                city.name.lowercased().contains(searchText.lowercased())
            }
            
            cities = matchingCities.map { city in
                Settlement(
                    title: city.name,
                    code: "",
                    lat: city.lat,
                    lng: city.lng
                )
            }
            
        } catch {
            errorMessage = "Ошибка поиска: \(error.localizedDescription)"
            cities = []
        }
        
        isLoading = false
    }
    
    func selectCity(_ city: Settlement) {
        // Город выбран, дальше будет переход к станциям
    }
}
