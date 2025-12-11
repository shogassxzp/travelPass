import Foundation

struct NearestCityResponse: Codable, Sendable {
    let distance: Double
    let code: String
    let title: String
    let popularTitle: String?
    let shortTitle: String?
    let lat: Double
    let lng: Double
    let type: String

    enum CodingKeys: String, CodingKey {
        case distance, code, title
        case popularTitle = "popular_title"
        case shortTitle = "short_title"
        case lat, lng, type
    }
}
