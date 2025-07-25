//
//  WeatherViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {

    private let weatherView = WeatherView()
    private var forecasts: [WeatherForecast] = []
    private var viewModel = WeatherViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func loadView() {
        self.view = weatherView
    }

    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        self.addActions()
        super.viewDidLoad()
        
        viewModel.$forecastList
            .sink { [weak self] list in
                self?.forecasts = list
                self?.weatherView.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$weatherResult
            .sink { [weak self] result in
                let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Confirm", style: .default, handler: nil)
                alert.addAction(okAction)
                switch result {
                case .none, .success:
                    return
                case .cityNotFound:
                    alert.title = "잘못된 도시이름입니다."
                    alert.message = "올바른 도시 이름을 입력해주세요."
                case .failedToFetchCityWeather:
                    alert.title = "날씨 정보 불러오기 실패."
                    alert.message = "네트워크를 확인해 주세요."
                case .noCityTyped:
                    alert.title = "도시를 입력하지 않았습니다."
                    alert.message = "한국의 도시 이름을 입력해주세요."
                }
                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            .store(in: &cancellables)
        
        weatherView.tableView.dataSource = self
        weatherView.tableView.delegate = self
    }
    
    deinit {
        viewModel.removeCancellables()
        cancellables.removeAll()
    }
    
}

// MARK: - Button Actions
extension WeatherViewController {
    
    func addActions() {
        self.weatherView.deleteDataButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        self.weatherView.refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        self.weatherView.searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
    }
    
    @objc
    private func search() {
        guard let city = self.weatherView.searchTextField.text else { return }
        self.viewModel.fetchWeatherData(of: city)
        
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.weatherView.indicator.isHidden = false
                    self?.weatherView.indicator.startAnimating()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.weatherView.indicator.stopAnimating()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    @objc
    private func refresh() {
        self.viewModel.getWeatherData()
    }
    
    @objc
    private func deleteData() {
        self.viewModel.deleteData()
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastCell.identifier, for: indexPath) as? WeatherForecastCell else {
            return UITableViewCell()
        }
        let forecast = forecasts[indexPath.row]
        cell.configure(with: forecast)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // touch cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedForecast = forecasts[indexPath.row]
        print("Selected forecast for: \(selectedForecast.dtTxt)")
    }
}
