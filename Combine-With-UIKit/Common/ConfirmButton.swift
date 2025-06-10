//
//  ConfirmButton.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit
import SnapKit

class ConfirmButton: UIButton {
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "다음"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 7
        self.backgroundColor = .TB_3
        self.isEnabled = false
        addComponents()
    }
    
    private func addComponents() {
        self.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func configure(labelText: String) {
        mainLabel.text = labelText
    }
    
    public func available() {
        self.backgroundColor = .TB
        self.isEnabled = true
    }
    
    public func unavailable() {
        self.backgroundColor = .TB_3
        self.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
