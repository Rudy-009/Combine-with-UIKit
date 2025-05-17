//
//  View.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/16/25.
//

import UIKit
import SnapKit

class BasicView: UIView {
    
    public lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap Me", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    public lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setUI() {
        self.addSubview(button)
        self.addSubview(label)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-20)
        }
    }
    
    public func confiure() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
