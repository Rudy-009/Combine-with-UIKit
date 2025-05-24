//
//  WeatherData.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/21/25.
//

import Foundation

// 최상위 응답 구조체
struct WeatherResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherForecast]
    let city: City
}

// 날씨 예보 항목 구조체
struct WeatherForecast: Codable {
    let dt: Int
    let main: MainWeatherData
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// 주요 날씨 데이터 구조체
struct MainWeatherData: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let seaLevel: Int
    let grndLevel: Int
    let humidity: Int
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// 날씨 상태 구조체
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// 구름 정보 구조체
struct Clouds: Codable {
    let all: Int
}

// 바람 정보 구조체
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

// 강수량 구조체
struct Rain: Codable {
    let threeHour: Double
    
    enum CodingKeys: String, CodingKey {
        case threeHour = "3h"
    }
}

// 시스템 정보 구조체
struct Sys: Codable {
    let pod: String
}

// 도시 정보 구조체
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

// 좌표 구조체
struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}
