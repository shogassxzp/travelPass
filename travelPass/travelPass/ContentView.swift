import OpenAPIURLSession
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("About project")
        }
        .padding()
        .onAppear {
//            testNearestStations()
//            testCopyright()
//            testSchedualBetweenStation()
//            testStationScheduleService()
//            testRouteStationService()
//            testNearestCityService()
//            testStationsListService()
//            testCarrierInfoService()
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
        Task {
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
        Task {
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

    func testStationScheduleService() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = StationScheduleService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )
                print("Fetching station schedule")
                let schedule = try await service.getStationSchedule(
                    station: "s9600366"
                )
                print("Succes fetched station schedule: \(schedule)")
            } catch {
                print("Error fetching station schedule: \(error)")
            }
        }
    }

    func testRouteStationService() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = RouteStationsService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )
                print("Fetching station route")
                let route = try await service.getRouteStations(uid: "FV-6951_260330_c8565_12")
                print("Succes fetched station route: \(route)")
            } catch {
                print("Error fetching station route: \(error)")
            }
        }
    }

    func testNearestCityService() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = NearestCityService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )
                print("Fetching nearest city")
                let city = try await service.getNearestCity(
                    lat: 59.864177,
                    lng: 30.319163
                )
                print("Succes fetched nearest city: \(city)")
            } catch {
                print("Error fetching nearest city: \(error)")
            }
        }
    }

    func testStationsListService() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = StationsListService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )
                print("Fetching all stations...")
                let stations = try await service.getAllStations()
                print("Successfully fetched all stations")
                print("Countries count: \(stations.countries?.count ?? 0)")
            } catch {
                print("Error fetching all stations: \(error)")
            }
        }
    }
    func testCarrierInfoService() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = CarrierInfoService(
                    client: client,
                    apikey: "4b5866df-0bfd-4e43-8816-3455a97dbbfd"
                )
                print("Fetching carrier info")
                let stations = try await service.getCarrierInfo(code: "111")
                print("Successfully fetched carrier info: \(stations)")
                
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
