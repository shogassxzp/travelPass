import Combine
import Foundation

@MainActor
class CityPickerViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var searchText = ""
    @Published var cities: [Settlement] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let cityService: CityService

    // MARK: - Computed Properties

    var cityNames: [String] {
        cities.map { $0.title }
    }

    // MARK: - Initializer

    init(cityService: CityService = DIContainer.shared.cityService) {
        self.cityService = cityService
        print("CityPickerViewModel created")
    }

    // MARK: - Public Methods

    func searchCities() async {
        guard !searchText.isEmpty else {
            await loadCities()
            return
        }

        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        let foundCities = await cityService.searchCities(by: searchText)

        await MainActor.run {
            self.cities = foundCities

            if foundCities.isEmpty {
                self.errorMessage = "Город не найден"
            }

            isLoading = false
        }
    }

    func loadCities() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        let allCities = await cityService.getCities()

        await MainActor.run {
            self.cities = allCities
            isLoading = false
        }
    }

    func getCity(by name: String) -> Settlement? {
        cities.first { $0.title == name }
    }
}
