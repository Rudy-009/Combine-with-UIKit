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
    
    private let networkService: WeatherNetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: WeatherNetworkServiceProtocol = WeatherNetworkService()) {
        self.networkService = networkService
        setupBindings()
    }
    
    private func setupBindings() {
        $weatherResponse
            .map { $0?.list ?? [] }
            .assign(to: \.forecastList, on: self)
            .store(in: &cancellables)
        $location
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.getWeatherData()
            }
            .store(in: &cancellables)
    }
    
    func fetchWeatherData(of city: String) {
        fetchLocation(of: city)
    }
    
    func fetchLocation(of city: String) {
        guard !city.isEmpty else {
            weatherResult = .noCityTyped
            return
        }
        isLoading = true
        networkService.fetchLocation(city: city)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(_) = completion {
                        self?.weatherResult = .cityNotFound
                        self?.isLoading = false
                    }
                },
                receiveValue: { [weak self] locations in
                    self?.location = locations.first
                }
            )
            .store(in: &cancellables)
    }
    
    func getWeatherData() {
        guard let location = location else { return }
        
        networkService.fetchWeather(lat: location.lat, lon: location.lon)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(_) = completion {
                        self?.weatherResult = .failedToFetchCityWeather
                    }
                },
                receiveValue: { [weak self] response in
                    self?.weatherResult = .success
                    self?.weatherResponse = response
                }
            )
            .store(in: &cancellables)
    }
    
    func removeCancellables() {
        cancellables.removeAll()
    }
    
    func deleteData() {
        forecastList.removeAll()
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
