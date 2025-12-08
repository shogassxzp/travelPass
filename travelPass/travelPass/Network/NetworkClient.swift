import Foundation

enum APIError: Error, Sendable {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case serverError(String)
    case noData

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case let .networkError(error):
            return "Ошибка сети: \(error.localizedDescription)"
        case let .decodingError(error):
            return "Ошибка обработки данных: \(error.localizedDescription)"
        case let .serverError(error):
            return "Ошибка сервера: \(error)"
        case .noData:
            return "Нет данных"
        }
    }
}

actor NetworkClient {
    private let apiKey: String
    private let baseURL = "https://api.rasp.yandex.net.ru/v3.0"
    private let decoder: JSONDecoder
    private let session: URLSession

    init(apiKey: String) {
        self.apiKey = apiKey
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        session = URLSession(configuration: configuration)
    }

    // 1. Поиск ближайшего города по координатам
    func getNearestCity(lat: Double, lng: Double, distance: Int = 50) async throws -> NearestCityResponse {
        try await makeRequest(
            endpoint: "/nearest_settlement/",
            queryItems: [
                "lat": "\(lat)",
                "lng": "\(lng)",
                "distance": "\(distance)",
                "lang": "ru_RU",
                "format": "json",
            ]
        )
    }

    // 2. Поиск станций вокруг города (в радиусе N км)
    func getNearestStations(lat: Double, lng: Double, distance: Int = 20) async throws -> [Station] {
        let response: StationsResponse = try await makeRequest(
            endpoint: "/nearest_stations/",
            queryItems: [
                "lat": "\(lat)",
                "lng": "\(lng)",
                "distance": "\(distance)",
                "lang": "ru_RU",
                "format": "json",
            ]
        )
        return response.stations ?? []
    }

    // 3. Поиск рейсов между станциями
    func searchSegments(from: String, to: String, date: String? = nil) async throws -> [Segment] {
        var queryItems: [String: String] = [
            "from": from,
            "to": to,
            "lang": "ru_RU",
            "format": "json",
        ]

        if let date = date {
            queryItems["date"] = date
        }

        let response: SegmentsResponse = try await makeRequest(
            endpoint: "/search/",
            queryItems: queryItems
        )

        return response.segments ?? []
    }

    // 4. Информация о перевозчике
    func getCarrierInfo(code: String) async throws -> Carrier? {
        let response: CarrierResponse = try await makeRequest(
            endpoint: "/carrier/",
            queryItems: [
                "code": code,
                "lang": "ru_RU",
                "format": "json",
            ]
        )
        return response.carriers?.first
    }

    // 5. Общий метод для запросов
    private func makeRequest<T: Decodable>(
        endpoint: String,
        queryItems: [String: String]
    ) async throws -> T {
        guard let url = buildURL(endpoint: endpoint, queryItems: queryItems) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networkError(NSError(domain: "Invalid response", code: -1))
            }

            guard (200 ... 299).contains(httpResponse.statusCode) else {
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                throw APIError.serverError("HTTP \(httpResponse.statusCode): \(errorMessage)")
            }

            // Для отладки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response (\(endpoint)): \(jsonString.prefix(500))...")
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                print("Decoding error: \(error)")
                throw APIError.decodingError(error)
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }

    private func buildURL(endpoint: String, queryItems: [String: String]) -> URL? {
        var components = URLComponents(string: baseURL + endpoint)
        var allQueryItems = [URLQueryItem(name: "apikey", value: apiKey)]

        for (key, value) in queryItems {
            allQueryItems.append(URLQueryItem(name: key, value: value))
        }

        components?.queryItems = allQueryItems
        return components?.url
    }
}
