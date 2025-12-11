import Combine
import Foundation

@MainActor
class FiltersViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var selectedTimes: Set<String> = []

    // MARK: - Properties

    let timeOptions = [
        ("Утро", "06:00 - 12:00"),
        ("День", "12:00 - 18:00"),
        ("Вечер", "18:00 - 00:00"),
        ("Ночь", "00:00 - 06:00"),
    ]

    // MARK: - Time Ranges

    private let timeRanges: [String: (start: Int, end: Int)] = [
        "Утро": (6, 12),
        "День": (12, 18),
        "Вечер": (18, 24),
        "Ночь": (0, 6),
    ]

    // MARK: - Computed Properties

    var isApplyButtonEnabled: Bool {
        !selectedTimes.isEmpty
    }

    // MARK: - Public Methods

    func resetFilters() {
        selectedTimes = []
    }

    // MARK: - Filtering Methods

    func filterSegmentsByTime(_ segments: [Segment]) -> [Segment] {
        guard !selectedTimes.isEmpty else {
            return segments
        }

        let filtered = segments.filter { segment in
            guard let hour = extractHour(from: segment.departure) else {
                return false
            }

            for timeKey in selectedTimes {
                if let range = timeRanges[timeKey] {
                    if isHourInRange(hour, range: range) {
                        return true
                    }
                }
            }

            return false
        }

        return filtered
    }

    // MARK: - Private Methods

    private func extractHour(from dateString: String) -> Int? {
        let formats = [
            "HH:mm:ss", "HH:mm",
        ]

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")

        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: dateString) {
                let hour = Calendar.current.component(.hour, from: date)
                return hour
            }
        }

        print("Не удалось распарсить время: \(dateString)")
        return nil
    }

    private func isHourInRange(_ hour: Int, range: (start: Int, end: Int)) -> Bool {
        if range.start < range.end {
            return hour >= range.start && hour < range.end
        } else {
            // Ночной диапазон (0-6)
            return hour >= range.start || hour < range.end
        }
    }
}
