//
//  SwitchViewController.swift
//  Combine-With-UIKit
//
//  Created by 이승준 on 11/2/25.
//

import UIKit
import Combine
import SnapKit

final class LighbulbViewController: UIViewController {
    
    let vc = SwitchViewController()
    private var cancellables: Set<AnyCancellable> = []
    
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
        subscribe()
    }
    
    func subscribe() {
        vc.lightbulbPublisher
        .receive(on: DispatchQueue.main)
        .sink { [weak self] event in
            guard let self else { return }
            var lightbulbImage: UIImage?
            switch event {
            case .on:
                lightbulbImage = UIImage(systemName: "lightbulb.max")
            case .off:
                lightbulbImage = UIImage(systemName: "lightbulb")
            }
            self.lightbulb.image = lightbulbImage
        }
        .store(in: &cancellables)
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
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        self.present(vc, animated: true)
    }
}

enum LightbulbEvent {
    case on, off
}

final class SwitchViewController: UIViewController {
    
    private lazy var subject = PassthroughSubject<LightbulbEvent, Never>()
    lazy var lightbulbPublisher = subject.eraseToAnyPublisher()
    
    @objc
    private func onLightbulbButtonTapped() {
        subject.send(.on)
    }
    
    @objc
    private func offLightbulbButtonTapped() {
        subject.send(.off)
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
    LighbulbViewController()
}

