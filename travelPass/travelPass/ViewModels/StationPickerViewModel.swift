import Combine
import Foundation

@MainActor
class StationPickerViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var searchText = ""
    @Published var stations: [Station] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Properties

    private let stationService: StationService
    let selectedCity: String

    // MARK: - Computed Properties

    var stationNames: [String] {
        stations.map { $0.title }
    }

    // MARK: - Initializer

    init(
        selectedCity: String,
        stationService: StationService = DIContainer.shared.stationService
    ) {
        self.selectedCity = selectedCity
        self.stationService = stationService
        print("StationPickerViewModel created for city \(selectedCity)")
    }

    // MARK: - Public Methods

    func loadStations() async {
        await MainActor.run {
            isLoading = false
            errorMessage = nil
        }
        do {
            let cityStations = stationService.getStationsForCityStatic(selectedCity)
            
            await MainActor.run {
                self.stations = cityStations
                
                if cityStations.isEmpty {
                    self.errorMessage = "Не найдено станций"
                }
            }
            
        } catch {
            await MainActor.run {
                self.errorMessage = "Ошибка загрузки"
            }
        }
        await MainActor.run {
            isLoading = false
        }
    }
    
    func filterStations() -> [Station] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { station in
                station.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    func getStation(by name: String) -> Station? {
        stations.first {$0.title == name}
    }
}
