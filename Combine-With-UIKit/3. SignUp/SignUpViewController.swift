import UIKit
import SnapKit
import Combine

final class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private let signUpViewModel = SignUpViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.setNameTextFieldPublisher()
    }
}

// MARK: 이름 입력 감지
extension SignUpViewController {
    private func setNameTextFieldPublisher() {
        signUpView.nameTextField.textPublisher()
            .assign(to: \.userName, on: signUpViewModel)
            .store(in: &cancellables)
        
        signUpViewModel.$isNicknameValid
            .sink { [weak self] isValid in
                self?.signUpView.checkValidation(type: .nickname, isValid: isValid)
            }
            .store(in: &cancellables)
        
        signUpViewModel.$isCheckingNickname
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isChecking in
                if isChecking {
                    self?.signUpView.nicknameIndicator.isHidden = false
                    self?.signUpView.nicknameIndicator.startAnimating()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.signUpView.nicknameIndicator.stopAnimating()
                    }
                }
            }
            .store(in: &cancellables)
    }
}

import SwiftUI
#Preview {
    SignUpViewController()
}
