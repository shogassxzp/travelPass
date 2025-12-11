import Combine
import Foundation

@MainActor
class MainScreenViewModel: ObservableObject {
    // MARK: - Published properties

    @Published var from = "Откуда"
    @Published var to = "Куда"
    @Published var showingCityPicker = false
    @Published var showingCarrierList = false
    @Published var selectedField: FieldType? = nil
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let stationService: StationService

    // MARK: - Types

    enum FieldType {
        case from, to
    }

    // MARK: - Initializer

    init(stationService: StationService = DIContainer.shared.stationService) {
        self.stationService = stationService
    }

    // MARK: - Computed Properties

    var isFindButtonEnabled: Bool {
        from != "Откуда" && to != "Куда"
    }

    // MARK: - Public Methods

    func selectField(_ field: FieldType) {
        selectedField = field
        showingCityPicker = true
    }

    func revert() {
        guard from != "Откуда", to != "Куда" else { return }
        let temp = from
        from = to
        to = temp
    }

    func validateRoute() async -> Bool {
        guard isFindButtonEnabled else { return false }

        isLoading = true
        errorMessage = nil

        do {

            let _ = try await stationService.searchSegments(from: from, to: to)
            isLoading = false
            return true
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            return false
        }
    }
}
