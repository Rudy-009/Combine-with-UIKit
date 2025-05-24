//
//  WeatherView.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit
import SnapKit

class WeatherView: UIView {
    
    public var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 17 // 셀 간 간격
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 68, height: 65)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"
    private var weatherInfo: WeatherForecast?
    
    private lazy var celciusLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "°C"
        label.textColor = .label
        return label
    }()
    
    
}
