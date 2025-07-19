import UIKit
import SnapKit

final class SignUpView: UIView {
    
    private let contentPadding: CGFloat = 35
    private let paddingLblTxt: CGFloat = 8

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let nicknameLabel = UILabel()
    let nicknameTextField = UITextField()
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    
    let passwordConfirmLabel = UILabel()
    let passwordConfirmTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
    
    private func setConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [nicknameLabel, nicknameTextField, nameLabel, nameTextField, emailLabel, emailTextField, passwordLabel, passwordTextField, passwordConfirmLabel, passwordConfirmTextField].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
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
} 
