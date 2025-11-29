import Combine

class ErrorManager: ObservableObject {
    @Published var showError = false
    @Published var errorType: ErrorType = .server
    
    func showServerError() {
        errorType = .server
        showError = true
    }
    func showInternetError() {
        errorType = .internet
        showError = true
    }
}
