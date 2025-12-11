import Foundation

struct Carrier: Codable, Identifiable, Sendable, Hashable {
    let code: Int
    let title: String
    let phone: String?
    let email: String?
    let url: String?
    let address: String?
    let logo: String?

    var id: Int { code }

    enum CodingKeys: String, CodingKey {
        case code, title, phone, email, url, address, logo
    }
}
