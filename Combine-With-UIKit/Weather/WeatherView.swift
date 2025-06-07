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
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.text = "사용자 이름"
        return label
    }()
    
    public lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 20, weight: .bold)
        return textField
    }()
    
    public lazy var button = ConfirmButton()
    
    public var deleteDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash.circle"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    public var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise.circle"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherForecastCell.self, forCellReuseIdentifier: WeatherForecastCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.addSubview(label)
        self.addSubview(searchTextField)
        self.addSubview(button)
        self.addSubview(tableView)
        self.addSubview(deleteDataButton)
        self.addSubview(refreshButton)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(100)
        }
        
        button.configure(labelText: "검색")
        button.available()
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(60)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalTo(button.snp.leading).offset(-20)
            make.height.equalTo(40)
            make.top.equalTo(label.snp.bottom).offset(20)
        }
        
        deleteDataButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalTo(label.snp.centerY)
            make.height.width.equalTo(50)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalTo(deleteDataButton.snp.leading).inset(20)
            make.centerY.equalTo(deleteDataButton)
            make.height.width.equalTo(50)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

