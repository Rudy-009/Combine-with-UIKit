//
//  WeatherViewModel.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var weatherResponse: WeatherResponse?
    @Published var forecastList: [WeatherForecast] = []
    var city: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $weatherResponse
            .map { $0?.list ?? [] }
            .assign(to: \.forecastList, on: self)
            .store(in: &cancellables)
    }
    
    func getWeatherData(from city: String) {
        self.city = city
        fetchCoordinates(for: city) { result in
            switch result {
            case .success(let location):
                self.fetchWeatherData(from: location) { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.forecastList = response.list
                        }
                    case .failure(_):
                        break
                    }
                }
            case .failure(let error):
                print("에러: \(error)")
            }
        }
    }
    
    func deleteData() {
        forecastList.removeAll()
    }

    func fetchCoordinates(for city: String, completion: @escaping (Result<Location, Error>) -> Void) {
        guard let weatherAPIKey = Bundle.main.weatherAPIKey else {
            print("API 키를 로드하지 못했습니다.")
            return
        }
        let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(city),KR&limit=1&appid=\(weatherAPIKey)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let locations = try JSONDecoder().decode([Location].self, from: data)
                if let first = locations.first {
                    completion(.success(first))
                } else {
                    completion(.failure(NSError(domain: "No location found", code: 0)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchWeatherData(from location: Location, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let weatherAPIKey = Bundle.main.weatherAPIKey else {
            print("API 키를 로드하지 못했습니다.")
            return
        }
        let urlString =  "http://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.lon)&appid=\(weatherAPIKey)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

struct Location: Decodable {
    let name: String
    let local_names: [String:String]
    let lat: Double
    let lon: Double
    let country: String?
    let state: String?
}
