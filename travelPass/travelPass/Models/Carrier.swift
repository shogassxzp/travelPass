import Foundation

struct Carrier: Codable, Identifiable, Sendable {
    let id = UUID()
    let code: Int
    let title: String
    let phone: String?
    let email: String?
    let url: String?
    let adress: String?
    let logo: String?
    
    enum CodingKeys: String, CodingKey {
        case code, title, phone, email, url, adress, logo
    }
}
