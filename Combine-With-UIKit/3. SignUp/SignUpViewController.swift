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
        self.setNicknameTextFieldPublisher()
        self.setEmailTextFieldPublisher()
        self.setPasswordTextFieldPublisher()
        self.setConfirmPasswordTextFieldPublisher()
        self.setSignUpButtonPublisher()
    }
}

// MARK: 이름 입력 감지

// 3. 유효성 검사완료 시 결과를 화면에 보여준다.
extension SignUpViewController {
    
    private func setNameTextFieldPublisher() {
        signUpView.nameTextField.textDidChangePublisher()
            .assign(to: \.userName, on: signUpViewModel)
            .store(in: &cancellables)
    }
}

// MARK: 닉네임 입력 감지
// 1. 사용자가 닉네임을 편집(입력/삭제)을 한다.
// 2. 편집이 끝난 0.5초 후에 유효성을 검사한다.
// (유효성 검사는 0.5초가 소요된다. debouncing 활용)
// 2.1. 유효성 검사중에 indicator가 뜬다.
// 2.2. 유효성 검사중에 다시 편집(입력/삭제)가 발생하면 유효성 검사를 취소 or 결과를 반영하지 않는다.
extension SignUpViewController {
    
    private func setNicknameTextFieldPublisher() {
        signUpView.nicknameTextField.textDidChangePublisher()
            .assign(to: \.nickname, on: signUpViewModel)
            .store(in: &cancellables)
        
        signUpViewModel.$isNicknameValid
            .receive(on: DispatchQueue.main)
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

// MARK: 이메일
extension SignUpViewController {
    
    private func setEmailTextFieldPublisher() {
        signUpView.emailTextField.textDidChangePublisher()
            .assign(to: \.enmail, on: signUpViewModel)
            .store(in: &cancellables)
        
        signUpViewModel.$isEmailValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.signUpView.checkValidation(type: .email, isValid: isValid)
            }
            .store(in: &cancellables)
    }
}

// MARK: 비밀번호
extension SignUpViewController {
    
    private func setPasswordTextFieldPublisher() {
        signUpView.passwordTextField.textDidChangePublisher()
            .assign(to: \.password, on: signUpViewModel)
            .store(in: &cancellables)
        
        signUpViewModel.$isPasswordValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.signUpView.checkValidation(type: .password, isValid: isValid)
            }
            .store(in: &cancellables)
    }
}

// MARK: 비밀번호 확인
extension SignUpViewController {
    
    private func setConfirmPasswordTextFieldPublisher() {
        signUpView.passwordConfirmTextField.textDidChangePublisher()
            .assign(to: \.confirmPassword, on: signUpViewModel)
            .store(in: &cancellables)
        
        signUpViewModel.$isConfirmPasswordValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.signUpView.checkValidation(type: .passwordConfirm, isValid: isValid)
            }
            .store(in: &cancellables)
    }
}

extension SignUpViewController {
    
    private func setSignUpButtonPublisher() {
        signUpViewModel.$isSignUpEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                if isEnabled {
                    self?.signUpView.submitButton.available()
                } else {
                    self?.signUpView.submitButton.unavailable()
                }
            }
            .store(in: &cancellables)
    }
    
}

import SwiftUI
#Preview {
    SignUpViewController()
}
