import Combine
import Foundation

@MainActor
class CarrierDetailsViewModel: ObservableObject {
    let carrier: Carrier
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var carrierDetails: Carrier?

    private let stationService: StationService

    init(carrier: Carrier, stationService: StationService) {
        self.carrier = carrier
        self.stationService = stationService
    }

    func loadCarrierDetails() async {
        isLoading = true
        errorMessage = nil

        do {
            if let details = try await stationService.getCarrierInfo(carrierCode: "\(carrier.code)") {
                await MainActor.run {
                    self.carrierDetails = details
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }

        isLoading = false
    }
}
