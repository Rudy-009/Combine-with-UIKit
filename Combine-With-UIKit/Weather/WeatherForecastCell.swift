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
        // 아이콘 이미지를 표시하기 위한 기본 설정입니다.
        // 실제 아이콘 로딩 로직은 필요에 따라 추가해야 합니다.
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

        tempLabel.text = String(format: "%.1f°C", forecast.main.temp)
        descriptionLabel.text = forecast.weather.first?.description ?? "날씨 정보 없음"

        // 아이콘 설정 (예시, 실제 아이콘 URL이나 에셋 이름으로 변경 필요)
        if let iconCode = forecast.weather.first?.icon {
            // 예: "01d". 실제로는 이 코드를 사용하여 이미지를 가져와야 합니다.
            // weatherIconImageView.image = UIImage(named: iconCode) // 로컬 에셋 사용 시
            // 혹은 URL을 통해 이미지를 비동기적으로 로드해야 합니다.
            // 지금은 플레이스홀더 이미지를 사용합니다.
            if #available(iOS 13.0, *) {
                weatherIconImageView.image = UIImage(systemName: "photo") // 시스템 아이콘으로 대체
            } else {
                // 이전 버전을 위한 대체 이미지
            }
        }
    }
}

