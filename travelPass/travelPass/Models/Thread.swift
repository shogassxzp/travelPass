import Foundation

struct Thread: Codable, Identifiable, Sendable {
    let uid: String
    let title: String
    let number: String?
    let carrier: Carrier?
    let transportType = "train"

    var id: String { uid }

    enum CodingKeys: String, CodingKey {
        case uid, title, number, carrier
    }
}
