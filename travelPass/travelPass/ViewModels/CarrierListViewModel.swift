import Combine

@MainActor
class CarriersListViewModel: ObservableObject {
    @Published var segments: [Segment] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingFilters = false
    @Published var navigationPath = [CarrierRoute]()
    
    private let stationService: StationService
    let fromText: String
    let toText: String
    
    enum CarrierRoute: Hashable {
        case filters
        case carrierDetails(Carrier)    
    }
    
    init(stationService: StationService, fromText: String, toText: String) {
        self.stationService = stationService
        self.fromText = fromText
        self.toText = toText
    }
    
    func loadSegments() async {
        isLoading = true
        errorMessage = nil
        
        // Здесь нужно получить коды станций из текста
        // Пока используем мок коды
        let fromCode = "s9600213" // Москва Курский
        let toCode = "s9600366"   // СПб Московский
        
        await stationService.searchSegments(fromStationCode: fromCode, toStationCode: toCode)
        
        await MainActor.run {
            self.segments = stationService.searchSegments
            self.errorMessage = stationService.errorMessage
            self.isLoading = stationService.isLoading
        }
    }
    
    func showFilters() {
        navigationPath.append(.filters)
    }
    
    func showCarrierDetails(_ carrier: Carrier) {
        navigationPath.append(.carrierDetails(carrier))
    }
    
    var isEmptyState: Bool {
        !isLoading && segments.isEmpty
    }
}
