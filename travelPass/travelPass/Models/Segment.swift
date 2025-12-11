import Foundation

struct Segment: Codable, Identifiable, Sendable {
    let from: Station
    let to: Station
    let departure: String
    let arrival: String
    let thread: Thread
    let duration: Int

    var id: String {
        "\(from.code)-\(to.code)-\(thread.uid)-\(departure)"
    }

    enum CodingKeys: String, CodingKey {
        case from, to, departure, arrival, thread, duration
    }

    var durationString: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        return "\(hours)ч \(minutes)м"
    }
    // departureTime

    // arivalTime
}
