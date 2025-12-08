import Foundation

struct Thread: Codable, Identifiable, Sendable {
    let id = UUID()
    let uid: String
    let title: String
    let number: String?
    let carrier: Carrier
    let transportType: String
    
    enum CodingKeys: String, CodingKey {
        case uid, title, number, carrier
        case transportType = "transport_type"
    }
}
