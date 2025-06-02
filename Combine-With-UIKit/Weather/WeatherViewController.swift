//
//  WeatherViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {

    private let weatherView = WeatherView() // 수정된 WeatherView 인스턴스 생성 [2]
    private var forecasts: [WeatherForecast] = []
    private var viewModel = WeatherViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func loadView() {
        print("WeatherViewController, loadView")
        self.view = weatherView
    }

    override func viewDidLoad() {
        print("WeatherViewController, viewDidLoad")
        self.addActions()
        super.viewDidLoad()
        
        viewModel.$forecastList
            .sink { [weak self] list in
                self?.forecasts = list
                self?.weatherView.tableView.reloadData()
            }
            .store(in: &cancellables)
        viewModel.loadSampleData()
        
        weatherView.tableView.dataSource = self
        weatherView.tableView.delegate = self
    }
    
}

// MARK: - Button Actions
extension WeatherViewController {
    func addActions() {
        self.weatherView.deleteDataButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        self.weatherView.refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    }
    
    @objc
    private func refresh() {
        self.viewModel.loadSampleData()
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


