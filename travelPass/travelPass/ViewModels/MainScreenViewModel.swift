import Combine

@MainActor
class MainScreenViewModel: ObservableObject {
    @Published var fromText = "Откуда"
    @Published var toText = "Куда"
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Для навигации
    @Published var showingCityPicker = false
    @Published var selectedField: FieldType? = nil
    @Published var navigationPath = [Route]()
    
    enum FieldType {
        case from, to
    }
    
    enum Route: Hashable {
        case carrierList(from: String, to: String)
        case cityPicker(FieldType)
        case stationPicker(FieldType, Settlement)
    }
    
    var isFindButtonEnabled: Bool {
        fromText != "Откуда" && toText != "Куда" && !isLoading
    }
    
    func swapCities() {
        guard fromText != "Откуда", toText != "Куда" else { return }
        let temp = fromText
        fromText = toText
        toText = temp
    }
    
    func selectField(_ field: FieldType) {
        selectedField = field
        showingCityPicker = true
    }
    
    func navigateToCarrierList() {
        navigationPath.append(.carrierList(from: fromText, to: toText))
    }
}
