import Combine

@MainActor
class FiltersViewModel: ObservableObject {
    @Published var selectedTimes: Set<String> = []
    @Published var showTransfers: String = ""
    
    let timeOptions = [
        ("Утро", "06:00 - 12:00"),
        ("День", "12:00 - 18:00"),
        ("Вечер", "18:00 - 00:00"),
        ("Ночь", "00:00 - 06:00"),
    ]
    
    var isApplyButtonEnabled: Bool {
        !selectedTimes.isEmpty && !showTransfers.isEmpty
    }
    
    func applyFilters() {
        // Применяем фильтры и закрываем экран
    }
}
