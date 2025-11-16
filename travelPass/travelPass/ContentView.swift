import OpenAPIURLSession
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            //testNearestStations()
            //testCopyright()
            testSchedualBetweenStation()
        }
    }

    func testNearestStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )

                let service = NearestStationsService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )

                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )

                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func testCopyright() {
        Task{
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = CopyrightService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )
                print("Fetching copyright")
                let copyright = try await service.getCopyright()
                print("Succes fetched copyright: \(copyright)")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    func testSchedualBetweenStation() {
        Task{
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = SchedualBetweenStationsService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )
                print("Fetching schedule")
                let schedule = try await service.getSchedualBetweenStations(
                    from: "s9600213",
                    to: "s9600366"
                )
                print("Succes fetched schedule: \(schedule)")
            } catch {
                print("Error fetching schedule: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
