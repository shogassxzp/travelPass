import Foundation

struct Station: Codable, Identifiable, Hashable, Sendable {
    let id = UUID()
    let title: String
    let code: String
    let stationType: String?
    let transportType: String?
    let lat: Double?
    let lng: Double?
    let distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case title, code
        case stationType = "station_type"
        case transportType = "transport_type"
        case lat, lng, distance
    }
}
