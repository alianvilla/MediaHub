//
//  APIClient.swift
//  MediaHub
//
//  Created by Alian Villa Ochoa on 2/1/25.
//

import Foundation

// MARK: - Estructura para la API
struct APIClient {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MjZjNjY4MjM1ZjFhMGNkYTRlNzA2MTMxYWQzMzdmNiIsIm5iZiI6MTczNTk0MjYwMC4zOTYsInN1YiI6IjY3Nzg2MWM4YWI1ZWM0YzNkYzcyNmQ0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ihiPtlOdjVZTYZPN8F6rgxhL9F8ftkMJKykVZ4qvEdI"

    // Función para hacer una solicitud a la API
    static func fetchData(from endpoint: String, queryItems: [URLQueryItem] = []) async throws -> Data {
        guard var components = URLComponents(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = queryItems

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": apiKey
        ]

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
