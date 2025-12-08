import Foundation

struct CityCoordinates {
    static let cities: [(name: String, lat: Double, lng: Double)] = [
        ("Москва", 55.7558, 37.6173),
        ("Санкт-Петербург", 59.9343, 30.3351),
        ("Казань", 55.7961, 49.1064),
        ("Екатеринбург", 56.8389, 60.6057),
        ("Новосибирск", 55.0084, 82.9357),
        ("Сочи", 43.5855, 39.7231),
        ("Краснодар", 45.0355, 38.9753),
        ("Нижний Новгород", 56.3269, 44.0059),
        ("Самара", 53.1959, 50.1002),
        ("Омск", 54.9893, 73.3682),
        ("Челябинск", 55.1644, 61.4368),
        ("Ростов-на-Дону", 47.2221, 39.7203),
        ("Уфа", 54.7351, 55.9587),
        ("Воронеж", 51.6608, 39.2003),
        ("Пермь", 58.0105, 56.2294),
        ("Волгоград", 48.7071, 44.5169),
        ("Красноярск", 56.0153, 92.8932),
        ("Саратов", 51.5331, 46.0342),
        ("Тюмень", 57.1522, 65.5272),
        ("Тольятти", 53.5078, 49.4204)
    ]
    
    static func getCoordinates(for cityName: String) -> (lat: Double, lng: Double)? {
        if let city = cities.first(where: { $0.name.lowercased() == cityName.lowercased() }) {
            return (lat: city.lat, lng: city.lng)
        }
        return nil
    }
    
    static func getCityInfo(for cityName: String) -> (name: String, lat: Double, lng: Double)? {
        return cities.first { $0.name.lowercased() == cityName.lowercased() }
    }
}
