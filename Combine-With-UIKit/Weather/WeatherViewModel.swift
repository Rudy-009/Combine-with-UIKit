//
//  WeatherViewModel.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var weatherResponse: WeatherResponse?
    @Published var forecastList: [WeatherForecast] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $weatherResponse
            .map { $0?.list ?? [] }
            .assign(to: \.forecastList, on: self)
            .store(in: &cancellables)
    }
    
    func loadSampleData() {
        print("WeatherViewModel, loadSampleData")
        // WeatherModel.swift에 정의된 구조체를 기반으로 예시 데이터를 만듭니다. [1]
        // 이 부분은 실제 API 응답을 모방한 더미 데이터입니다.
        // 날짜 문자열은 API 응답 형식("yyyy-MM-dd HH:mm:ss")을 따릅니다.
        let sampleMain1 = MainWeatherData(temp: 25.0, feelsLike: 26.0, tempMin: 22.0, tempMax: 28.0, pressure: 1012, seaLevel: 1012, grndLevel: 1000, humidity: 60, tempKf: nil)
        let sampleWeather1 = [Weather(id: 800, main: "Clear", description: "맑음", icon: "01d")]
        let sampleClouds1 = Clouds(all: 0)
        let sampleWind1 = Wind(speed: 1.5, deg: 180, gust: 2.0)
        let sampleSys1 = Sys(pod: "d")
        let forecast1 = WeatherForecast(dt: 1622600400, main: sampleMain1, weather: sampleWeather1, clouds: sampleClouds1, wind: sampleWind1, visibility: 10000, pop: 0.1, rain: nil, sys: sampleSys1, dtTxt: "2025-06-02 12:00:00")

        let sampleMain2 = MainWeatherData(temp: 23.5, feelsLike: 24.0, tempMin: 21.0, tempMax: 27.0, pressure: 1010, seaLevel: 1010, grndLevel: 998, humidity: 65, tempKf: nil)
        let sampleWeather2 = [Weather(id: 802, main: "Clouds", description: "구름 조금", icon: "03d")]
        let sampleClouds2 = Clouds(all: 40)
        let sampleWind2 = Wind(speed: 2.5, deg: 200, gust: 3.0)
        let sampleSys2 = Sys(pod: "d")
        let forecast2 = WeatherForecast(dt: 1622611200, main: sampleMain2, weather: sampleWeather2, clouds: sampleClouds2, wind: sampleWind2, visibility: 10000, pop: 0.2, rain: nil, sys: sampleSys2, dtTxt: "2025-06-02 15:00:00")

        let sampleMain3 = MainWeatherData(temp: 26.0, feelsLike: 27.0, tempMin: 23.0, tempMax: 29.0, pressure: 1011, seaLevel: 1011, grndLevel: 999, humidity: 55, tempKf: nil)
        let sampleWeather3 = [Weather(id: 801, main: "Clouds", description: "약간의 구름", icon: "02d")]
        let sampleClouds3 = Clouds(all: 20)
        let sampleWind3 = Wind(speed: 2.0, deg: 190, gust: 2.5)
        let sampleSys3 = Sys(pod: "d")
        let forecast3 = WeatherForecast(dt: 1622622000, main: sampleMain3, weather: sampleWeather3, clouds: sampleClouds3, wind: sampleWind3, visibility: 10000, pop: 0.0, rain: nil, sys: sampleSys3, dtTxt: "2025-06-02 18:00:00")

        let sampleMain4 = MainWeatherData(temp: 24.5, feelsLike: 25.0, tempMin: 22.0, tempMax: 27.0, pressure: 1009, seaLevel: 1009, grndLevel: 997, humidity: 70, tempKf: nil)
        let sampleWeather4 = [Weather(id: 500, main: "Rain", description: "가벼운 비", icon: "10d")]
        let sampleClouds4 = Clouds(all: 50)
        let sampleWind4 = Wind(speed: 3.0, deg: 210, gust: 3.5)
        let sampleRain4 = Rain(threeHour: 0.5)
        let sampleSys4 = Sys(pod: "d")
        let forecast4 = WeatherForecast(dt: 1622632800, main: sampleMain4, weather: sampleWeather4, clouds: sampleClouds4, wind: sampleWind4, visibility: 8000, pop: 0.5, rain: sampleRain4, sys: sampleSys4, dtTxt: "2025-06-02 21:00:00")

        self.forecastList = [forecast1, forecast2, forecast3, forecast4, forecast1, forecast2, forecast3]
    }
    func deleteData() {
        forecastList.removeAll()
    }
}
