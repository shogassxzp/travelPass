import Foundation

struct Segment: Codable, Identifiable, Sendable {
    let id = UUID()
    let from: Station
    let to: Station
    let departure: String
    let arrival: String
    let duration: Int
    
    enum CodingKeys: String, CodingKey {
        case from, to, departure, arrival, duration
    }
    
    var durationString: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        return "\(hours)ч \(minutes)м"
    }
    //departureTime
    
    //arivalTime
}
