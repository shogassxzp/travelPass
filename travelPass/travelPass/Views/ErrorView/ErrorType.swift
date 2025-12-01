import Foundation

enum ErrorType {
    case internet
    case server

    var imageName: String {
        switch self {
        case .internet: return "NoInternet"
        case .server: return "ServerError"
        }
    }

    var title: String {
        switch self {
        case .internet: return "Нет интернета"
        case .server: return "Ошибка сервера"
        }
    }
}
