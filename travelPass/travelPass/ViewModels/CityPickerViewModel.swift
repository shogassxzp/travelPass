import Combine

@MainActor
class CityPickerViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var searchText = ""
    @Published var cities: [Settlement] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let stationService: StationService

    // MARK: - Computed Properties

    var cityNames: [String] {
        cities.map { $0.title }
    }

    // MARK: - Initializer

    init(stationService: StationService = DIContainer.shared.stationService) {
        self.stationService = stationService
        print("CityPickerViewModel created")
    }

    // MARK: - Public Methods

    func searchCities() async {
        guard !searchText.isEmpty else {
            await loadPopularCities()
            return
        }
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        do {
            let foundCities = await stationService.searchCitiesStatic(searchText)

            await MainActor.run {
                self.cities = foundCities

                if foundCities.isEmpty {
                    self.errorMessage = "Город не найден"
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Ошибка поиска"
            }
        }
        await MainActor.run {
            isLoading = false
        }
    }

    func loadPopularCities() async {
        await MainActor.run {
            isLoading = true
        }
        let popularCities = CityCoordinates.cities.map { city in
            Settlement(
                title: city.name,
                code: city.code,
                lat: city.lat,
                lng: city.lng
            )
        }
        await MainActor.run {
            self.cities = popularCities
            isLoading = false
        }
    }

    func getCity(by name: String) -> Settlement? {
        cities.first { $0.title == name }
    }
}
