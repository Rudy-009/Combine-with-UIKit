import Foundation
import Combine

final class SignUpViewModel {
    
    @Published var nickname: String = ""
    @Published var isNicknameValid: Bool = false
    @Published var isCheckingNickname: Bool = false
    
    @Published var userName: String = ""
    @Published var isUserNameFilled: Bool = false
    
    @Published var isSignUpEnabled: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $userName
            .sink { [weak self] userName in
                self?.isUserNameFilled = !userName.isEmpty
            }
            .store(in: &cancellables)
    }
}
