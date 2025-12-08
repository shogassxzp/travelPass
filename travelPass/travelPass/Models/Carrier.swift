import Foundation

struct Carrier: Codable, Identifiable, Sendable, Hashable {
    let id = UUID()
    let code: Int
    let title: String
    let phone: String?
    let email: String?
    let url: String?
    let address: String?
    let logo: String?
    
    enum CodingKeys: String, CodingKey {
        case code, title, phone, email, url, address, logo
    }
}
