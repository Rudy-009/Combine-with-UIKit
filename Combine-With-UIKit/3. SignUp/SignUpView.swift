import UIKit
import SnapKit

final class SignUpView: UIView {
    
    private let contentPadding: CGFloat = 35
    private let paddingLblTxt: CGFloat = 8

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let nicknameLabel = UILabel()
    let nicknameTextField = UITextField()
    let nicknameIndicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .TB
        return indicator
    }()
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    
    let passwordConfirmLabel = UILabel()
    let passwordConfirmTextField = UITextField()
    
    let submitButton = ConfirmButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        setConstraints()
        configureScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScrollView() {
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.delaysContentTouches = false
    }
    
    private func configureUI() {
        nicknameLabel.text = "닉네임"
        nameLabel.text = "이름"
        emailLabel.text = "이메일"
        passwordLabel.text = "비밀번호"
        passwordConfirmLabel.text = "비밀번호 확인"
        
        [nicknameTextField, nameTextField, emailTextField, passwordTextField, passwordConfirmTextField].forEach {
            $0.borderStyle = .roundedRect
        }
        
        passwordTextField.isSecureTextEntry = true
        passwordConfirmTextField.isSecureTextEntry = true
        submitButton.configure(labelText: "가입")
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [submitButton, nicknameLabel, nicknameTextField, nicknameIndicator, nameLabel, nameTextField, emailLabel, emailTextField, passwordLabel, passwordTextField, passwordConfirmLabel, passwordConfirmTextField, ].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(submitButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        nicknameIndicator.color = .TB_2
        nicknameIndicator.snp.makeConstraints { make in
            make.centerY.trailing.equalTo(nicknameTextField)
            make.height.width.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(contentPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(paddingLblTxt)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(contentPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(paddingLblTxt)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(contentPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(paddingLblTxt)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordConfirmLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(contentPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        passwordConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordConfirmLabel.snp.bottom).offset(paddingLblTxt)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        
    }
    
    enum SignUpComponetType {
        case nickname
        case name
        case email
        case password
        case passwordConfirm
        
        func succeedText() -> String {
            switch self {
            case .nickname:
                return "사용가능한 닉네임입니다."
            case .name:
                return "이름"
            case .email:
                return "이메일"
            case .password:
                return "비밀번호"
            case .passwordConfirm:
                return "비밀번호 확인"
            }
        }
        
        func errorMessage() -> String {
            switch self {
            case .nickname:
                return "4~12자의 알파벳과 숫자를 사용하세요."
            case .name:
                return "2~10자의 알파벳과 숫자를 사용하세요."
            case .email:
                return "올바른 이메일 형식이 아닙니다."
            case .password:
                return "비밀번호 조건"
            case .passwordConfirm:
                return "입력하신 비밀번호와 일치하지 않습니다."
            }
        }
    }
    
    enum ValidatoinColor {
        case succeed, failed
        
        func color() -> UIColor {
            switch self {
            case .succeed:
                return .TB
            case .failed:
                return .red400
            }
        }
    }
    
    func checkValidation(type: SignUpComponetType, isValid: Bool?) {
        guard let isValid = isValid else { return }
        switch type {
        case .nickname:
            self.nicknameLabel.text = isValid ? type.succeedText() : type.errorMessage()
            self.nicknameLabel.textColor = isValid ? ValidatoinColor.succeed.color() : ValidatoinColor.failed.color()
        case .name:
            self.nameLabel.text = isValid ? type.succeedText() : type.errorMessage()
            self.nameLabel.textColor = isValid ? ValidatoinColor.succeed.color() : ValidatoinColor.failed.color()
        case .email:
            self.emailLabel.text = isValid ? type.succeedText() : type.errorMessage()
            self.emailLabel.textColor = isValid ? ValidatoinColor.succeed.color() : ValidatoinColor.failed.color()
        case .password:
            self.passwordLabel.text = isValid ? type.succeedText() : type.errorMessage()
            self.passwordLabel.textColor = isValid ? ValidatoinColor.succeed.color() : ValidatoinColor.failed.color()
        case .passwordConfirm:
            self.passwordConfirmLabel.text = isValid ? type.succeedText() : type.errorMessage()
            self.passwordConfirmLabel.textColor = isValid ? ValidatoinColor.succeed.color() : ValidatoinColor.failed.color()
        }
    }
}

import SwiftUI
#Preview {
    SignUpViewController()
}
