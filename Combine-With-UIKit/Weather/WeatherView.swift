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
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherForecastCell.self, forCellReuseIdentifier: WeatherForecastCell.identifier)
        // 테이블 뷰의 rowHeight를 동적으로 설정하거나 고정 값으로 설정할 수 있습니다.
        // tableView.rowHeight = UITableView.automaticDimension
        // tableView.estimatedRowHeight = 100 // 예상 높이, automaticDimension과 함께 사용
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.addSubview(label)
        self.addSubview(tableView)
        
        label.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(100)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

