//
//  WeatherViewModel.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var weatherResponse: WeatherResponse?
    @Published var forcasrList: [WeatherForecast] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $weatherResponse
            .map { $0?.list ?? [] }
            .assign(to: \.forcasrList, on: self)
            .store(in: &cancellables)
    }
    
}
