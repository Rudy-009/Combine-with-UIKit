//
//  WeatherViewModel.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var location: Location?
    @Published var weatherResponse: WeatherResponse?
    @Published var forecastList: [WeatherForecast] = []
    @Published var isLoading: Bool = false
    @Published var weatherResult: FetchWeatherResult?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $weatherResponse
            .map { $0?.list ?? [] }
            .assign(to: \.forecastList, on: self)
            .store(in: &cancellables)
        // location의 값에 변화가 생기면, 데이터를 불러온다.
        $location
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.getWeatherData()
            })
            .store(in: &cancellables)
    }
    
    func removeCancellables() {
        cancellables.removeAll()
    }
    
    func deleteData() {
        forecastList.removeAll()
    }
    
    func fetchWeatherData(of city: String) {
        getLocation(of: city)
    }
    
    func getLocation(of city: String) {
        guard let weatherAPIKey = Bundle.main.weatherAPIKey else {
            return
        }
        let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(city),KR&limit=1&appid=\(weatherAPIKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Location].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.weatherResult = .cityNotFound
                    print("getLocation failed: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { locations in
                self.location = locations.first
            })
            .store(in: &cancellables)
    }
    
    func getWeatherData() {
        self.isLoading = true
        guard let weatherAPIKey = Bundle.main.weatherAPIKey else {
            return
        }
        guard let _ = self.location else {
            return
        }
        let urlString =  "http://api.openweathermap.org/data/2.5/forecast?lat=\(self.location!.lat)&lon=\(self.location!.lon)&appid=\(weatherAPIKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.weatherResult = .failedToFetchCityWeather
                    print("getWeatherData failed: \(error)")
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { response in
                DispatchQueue.main.async {
                    self.weatherResult = .success
                    self.weatherResponse = response
                }
            })
            .store(in: &cancellables)
    }
    
}

enum FetchWeatherResult {
    case success, cityNotFound, failedToFetchCityWeather, noCityTyped
}

struct Location: Decodable {
    let name: String
    let local_names: [String:String]
    let lat: Double
    let lon: Double
    let country: String?
    let state: String?
}
