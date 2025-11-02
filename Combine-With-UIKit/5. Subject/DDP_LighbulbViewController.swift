//
//  TestDrivenViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 5/17/25.
//

import UIKit
import SnapKit

final class DDP_LighbulbViewController: UIViewController, SwitchProtocol {
    
    func toggleLightbulb(_ bool: Bool?) {
        switch bool {
        case .none:// 구독 취소
            return
        case true: // On
            self.lightbulb.image = UIImage(systemName: "lightbulb.max")
        case false: // Off
            self.lightbulb.image = UIImage(systemName: "lightbulb")
        }
    }
    
    private lazy var lightbulb: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lightbulb"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Switch", for: .normal)
        button.addTarget(self, action: #selector(showSwitchVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .black
        setUI()
    }
    
    func setUI() {
        self.view.addSubview(lightbulb)
        self.view.addSubview(button)
        
        lightbulb.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-130)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func showSwitchVC() {
        let vc = DDP_SwitchViewController()
        vc.configure(delegate: self)
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        self.present(vc, animated: true)
    }
}

protocol SwitchProtocol: AnyObject {
    func toggleLightbulb(_ bool: Bool?) // nil이면 전선 끊기
}

final class DDP_SwitchViewController: UIViewController {
    
    private weak var delegate: SwitchProtocol?
    
    @objc
    private func onLightbulbButtonTapped() {
        delegate?.toggleLightbulb(true)
    }
    
    @objc
    private func offLightbulbButtonTapped() {
        delegate?.toggleLightbulb(false)
    }
    
    func configure(delegate: SwitchProtocol) {
        self.delegate = delegate
    }
    
    private lazy var onLightbulbButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "lightbulb.max"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(onLightbulbButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var offLightbulbButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "lightbulb"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.backgroundColor = .systemGray
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(offLightbulbButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setUI()
    }
        
    func setUI() {
        let buttons = [onLightbulbButton, offLightbulbButton]
        
        self.view.addSubview(onLightbulbButton)
        self.view.addSubview(offLightbulbButton)
        
        buttons.forEach {
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageView?.snp.makeConstraints { make in
                make.height.width.equalTo(100)
            }
        }
        
        onLightbulbButton.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(150)
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview().offset(-80)
        }
        
        offLightbulbButton.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(150)
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview().offset(80)
        }
    }
    
}

#Preview {
    DDP_LighbulbViewController()
}
