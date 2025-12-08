import SwiftUI
import Combine

@MainActor
class StationPickerViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var stations: [Station] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let stationService: StationService
    let selectedCity: Settlement
    
    init(stationService: StationService, selectedCity: Settlement) {
        self.stationService = stationService
        self.selectedCity = selectedCity
    }
    
    func loadStations() async {
        isLoading = true
        errorMessage = nil
        
        await stationService.getStationsForCity(selectedCity)
        
        await MainActor.run {
            self.stations = stationService.searchResults
            self.errorMessage = stationService.errorMessage
            self.isLoading = stationService.isLoading
        }
    }
    
    func searchStations() async {
        guard !searchText.isEmpty else {
            await loadStations()
            return
        }
        
        let filtered = stations.filter { station in
            station.title.lowercased().contains(searchText.lowercased())
        }
        
        stations = filtered
    }
    
    func selectStation(_ station: Station) -> String {
        return "\(selectedCity.title) (\(station.title.replacingOccurrences(of: "\(selectedCity.title) ", with: "")))"
    }
}
