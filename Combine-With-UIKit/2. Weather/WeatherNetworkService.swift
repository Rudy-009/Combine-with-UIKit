//
//  WeatherNetworkService.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 6/15/25.
//

import Combine
import Foundation

protocol WeatherNetworkServiceProtocol {
    func fetchLocation(city: String) -> AnyPublisher<[Location], WeatherNetworkError>
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, WeatherNetworkError>
}

final class WeatherNetworkService: WeatherNetworkServiceProtocol {
    func fetchLocation(city: String) -> AnyPublisher<[Location], WeatherNetworkError> {
        guard let weatherAPIKey = Bundle.main.weatherAPIKey else {
            return Fail(error: WeatherNetworkError.weatherAPIKeyNotFound)
                .eraseToAnyPublisher()
        }
        let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(city),KR&limit=1&appid=\(weatherAPIKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: WeatherNetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Location].self, decoder: JSONDecoder())
            .mapError { error -> WeatherNetworkError in
                if error is DecodingError {
                    return .decodingError
                } else {
                    return .networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, WeatherNetworkError> {
        guard let weatherAPIKey = Bundle.main.weatherAPIKey else {
            return Fail(error: WeatherNetworkError.weatherAPIKeyNotFound)
                .eraseToAnyPublisher()
        }
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(weatherAPIKey)"
        guard let url = URL(string: urlString) else {
            return Fail(error: WeatherNetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw WeatherNetworkError.invalidResponse
                }
                return data
            }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .mapError { error -> WeatherNetworkError in
                if error is DecodingError {
                    return .decodingError
                } else {
                    return .networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

enum WeatherNetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case networkError(Error)
    case weatherAPIKeyNotFound
}
