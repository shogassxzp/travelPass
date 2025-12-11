struct Station: Codable, Identifiable, Hashable, Sendable {
    let title: String
    let code: String
    let stationType: String?
    let transportType: String?
    let lat: Double?
    let lng: Double?
    let distance: Double?
    
    var id: String { code }
    
    var isRailwayStation: Bool {
        let type = stationType?.lowercased() ?? ""
        let titleLower = title.lowercased()
        
        return type.contains("train") ||
               type.contains("railway") ||
               titleLower.contains("вокзал") &&
               !titleLower.contains("автовокзал") &&
               !titleLower.contains("автостанция")
    }
    
    enum CodingKeys: String, CodingKey {
        case title, code
        case stationType = "station_type"
        case transportType = "transport_type"
        case lat, lng, distance
    }
}
