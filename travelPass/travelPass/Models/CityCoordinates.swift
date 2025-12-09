import Foundation

struct CityCoordinates {
    struct City {
        let name: String
        let lat: Double
        let lng: Double
        let code: String
        let stations: [Station]
    }
    
    static let cities: [City] = [
        City(
            name: "Москва",
            lat: 55.7558,
            lng: 37.6173,
            code: "c213",
            stations: [
                Station(
                    title: "Москва (Курский вокзал)",
                    code: "s9600213",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.756,
                    lng: 37.658,
                    distance: 0.5
                ),
                Station(
                    title: "Москва (Ленинградский вокзал)",
                    code: "s9600215",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.776,
                    lng: 37.655,
                    distance: 1.2
                ),
                Station(
                    title: "Москва (Казанский вокзал)",
                    code: "s9600217",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.774,
                    lng: 37.657,
                    distance: 1.5
                ),
                Station(
                    title: "Москва (Киевский вокзал)",
                    code: "s9600216",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.742,
                    lng: 37.565,
                    distance: 2.3
                ),
                Station(
                    title: "Москва (Ярославский вокзал)",
                    code: "s9600214",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.776,
                    lng: 37.658,
                    distance: 1.8
                )
            ]
        ),
        City(
            name: "Санкт-Петербург",
            lat: 59.9343,
            lng: 30.3351,
            code: "c2",
            stations: [
                Station(
                    title: "Санкт-Петербург (Московский вокзал)",
                    code: "s9600366",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.929,
                    lng: 30.363,
                    distance: 0.3
                ),
                Station(
                    title: "Санкт-Петербург (Ладожский вокзал)",
                    code: "s9602498",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.932,
                    lng: 30.440,
                    distance: 1.1
                ),
                Station(
                    title: "Санкт-Петербург (Финляндский вокзал)",
                    code: "s9602499",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 59.956,
                    lng: 30.356,
                    distance: 0.8
                )
            ]
        ),
        City(
            name: "Казань",
            lat: 55.7961,
            lng: 49.1064,
            code: "c43",
            stations: [
                Station(
                    title: "Казань (Центральный вокзал)",
                    code: "s9604000",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 55.791,
                    lng: 49.108,
                    distance: 0.2
                )
            ]
        ),
        City(
            name: "Екатеринбург",
            lat: 56.8389,
            lng: 60.6057,
            code: "c54",
            stations: [
                Station(
                    title: "Екатеринбург (Вокзал)",
                    code: "s9604001",
                    stationType: "train_station",
                    transportType: "train",
                    lat: 56.840,
                    lng: 60.607,
                    distance: 0.1
                )
            ]
        )
    ]
    
    static func getCityInfo(for cityName: String) -> City? {
        return cities.first { $0.name.lowercased() == cityName.lowercased() }
    }
    
    static func getCoordinates(for cityName: String) -> (lat: Double, lng: Double)? {
        if let city = getCityInfo(for: cityName) {
            return (lat: city.lat, lng: city.lng)
        }
        return nil
    }
    
    static func getStations(for cityName: String) -> [Station] {
        return getCityInfo(for: cityName)?.stations ?? []
    }
    
    static func getStationCode(for stationName: String) -> String? {
        for city in cities {
            if let station = city.stations.first(where: { $0.title == stationName }) {
                return station.code
            }
        }
        return nil
    }
}
