import Foundation
import Combine

@MainActor
class DIContainer: ObservableObject {
    
    
    static let shared = DIContainer()
    
    private let apiKey = "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
    
    private(set) lazy var networkClient: NetworkClient = {
        NetworkClient(apiKey: apiKey)
    }()
    
    private(set) lazy var stationService: StationService = {
       StationService(apiKey: apiKey)
    }()
    
    private init(){}
}
