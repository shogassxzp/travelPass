import Combine
import Foundation

@MainActor
class CarriersListViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var segments: [Segment] = []
    @Published var filteredSegments: [Segment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var navigationPath = [CarrierRoute]()

    // MARK: - Properties

    private let stationService: StationService
    let fromText: String
    let toText: String

    // Фильтры
    @Published var filtersViewModel = FiltersViewModel()

    // MARK: - Types

    enum CarrierRoute: Hashable {
        case filters
        case carrierDetails(Carrier)
    }

    // MARK: - Initializer

    init(
        stationService: StationService = DIContainer.shared.stationService,
        fromText: String,
        toText: String
    ) {
        self.stationService = stationService
        self.fromText = fromText
        self.toText = toText
        print("CarriersListViewModel создан для: \(fromText) → \(toText)")
    }

    // MARK: - Public Methods

    func loadSegments() async {
        isLoading = true
        errorMessage = nil

        do {
            let segments = try await stationService.searchSegments(
                from: fromText,
                to: toText
            )

            await MainActor.run {
                self.segments = segments
                self.filteredSegments = segments

                if segments.isEmpty {
                    self.errorMessage = "Рейсы не найдены"
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
                self.segments = []
                self.filteredSegments = []
            }
        }
        isLoading = false
    }

    func applyFilters() {
        filteredSegments = filtersViewModel.filterSegmentsByTime(segments)
    }

    func showCarrierDetails(_ carrier: Carrier) {
        navigationPath.append(.carrierDetails(carrier))
    }

    func showFilters() {
        navigationPath.append(.filters)
    }
}
