import Combine
import Foundation

@MainActor
class CarriersListViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var segments: [Segment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingFilters = false
    @Published var navigationPath = [CarrierRoute]()

    // MARK: - Dependencies

    private let stationService: StationService

    // MARK: - Route Data

    let fromText: String
    let toText: String

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
        print("CarrierListViewModel crated for route \(fromText) -> \(toText)")
    }

    // MARK: - Public Methods

    func loadSegments() async {
        isLoading = true
        errorMessage = nil

        do {
            segments = try await stationService.searchSegments(
                from: fromText,
                to: toText
            )

            if segments.isEmpty {
                print("Реальных данных нет, используем моки")
                segments = getMockSegments()
            }
        } catch {
            errorMessage = error.localizedDescription
            print("error \(error)")
            segments = getMockSegments()
        }
        isLoading = false
    }

    func showCarrierDetails(_ carrier: Carrier) {
        navigationPath.append(.carrierDetails(carrier))
    }

    func showFilters() {
        navigationPath.append(.filters)
    }

    // MARK: - Mock Data

    private func getMockSegments() -> [Segment] {
        // Используем существующий метод из StationService
        let fromCode = parseStationCode(fromText)
        let toCode = parseStationCode(toText)
        return stationService.getMockSegments(fromCode: fromCode, toCode: toCode)
    }

    private func parseStationCode(_ text: String) -> String {
        // Простой парсинг для тестов
        if text.contains("Москва") {
            return "s9600213"
        } else if text.contains("Санкт-Петербург") {
            return "s9600366"
        } else if text.contains("Казань") {
            return "s9604000"
        } else {
            return "s9600213"
        }
    }
}
