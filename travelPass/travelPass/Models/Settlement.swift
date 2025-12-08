import Foundation


struct Settlement: Codable, Identifiable, Hashable, Sendable {
    let id = UUID()
    let title: String
    let code: String
    let lat: Double
    let lng: Double
        
    enum CodingKeys: String, CodingKey {
        case title
        case code
        case lat
        case lng
        
        static let moscow = Settlement(
               title: "Москва",
               code: "c213",
               lat: 55.7558,
               lng: 37.6173
           )
           
           static let spb = Settlement(
               title: "Санкт-Петербург",
               code: "c2",
               lat: 59.9343,
               lng: 30.3351
           )
    }
}

