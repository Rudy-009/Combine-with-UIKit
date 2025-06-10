//
//  WeatherForecastCell.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 6/2/25.
//

import UIKit
import SnapKit

final class WeatherForecastCell: UITableViewCell {

    static let identifier = "WeatherForecastCell"

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(descriptionLabel)

        weatherIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50) // 아이콘 크기 조절
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(weatherIconImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }

        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(dateLabel.snp.leading)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(8)
            make.leading.equalTo(dateLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    public func configure(with forecast: WeatherForecast) {
        // 날짜 변환 (예시: "yyyy-MM-dd HH:mm:ss" -> "MM/dd HH:mm")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: forecast.dtTxt) {
            dateFormatter.dateFormat = "MM/dd HH:mm"
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = forecast.dtTxt
        }
        
        tempLabel.text = String(format: "%.1f°C", forecast.main.temp - 273.15)
        descriptionLabel.text = forecast.weather.first?.description ?? "날씨 정보 없음"
        
        if let iconCode = forecast.weather.first?.icon {
            if let cachedImage = WeatherIconCacheManager.shared.image(forKey: iconCode) {
                weatherIconImageView.image = cachedImage
            } else {
                let iconURLString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                if let iconURL = URL(string: iconURLString) {
                    let task = URLSession.shared.dataTask(with: iconURL) { data, _, error in
                        guard let data = data, error == nil,
                              let image = UIImage(data: data) else {
                            return
                        }
                        WeatherIconCacheManager.shared.setImage(image, forKey: iconCode)
                        DispatchQueue.main.async {
                            self.weatherIconImageView.image = image
                        }
                    }
                    task.resume()
                }
            }
        } else {
            weatherIconImageView.image = nil
        }
    }
}

final class WeatherIconCacheManager {
    static let shared = WeatherIconCacheManager()
    private init() {}

    private let imageCache = NSCache<NSString, UIImage>()

    func image(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }

    func setImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
}

