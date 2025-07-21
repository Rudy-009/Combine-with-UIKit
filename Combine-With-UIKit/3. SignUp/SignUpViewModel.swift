import Foundation
import Combine

final class SignUpViewModel {
    
    @Published var userName: String = ""
    @Published var isUserNameFilled: Bool = false
    
    @Published var nickname: String = ""
    @Published var isNicknameValid: Bool?
    @Published var isCheckingNickname: Bool = false
    var nicknameWorkItem: DispatchWorkItem?
    
    @Published var isSignUpEnabled: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let nicknameCheckingService = NicknameCheckingServiceMock()
    
    init() {
        setupUserNameValidation()
        setupNicknameValidation()
    }
    
    private func setupUserNameValidation() {
        $userName
            .map { !$0.isEmpty }
            .assign(to: &$isUserNameFilled)
    }
    
    private func setupNicknameValidation() {
        $nickname
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] nickname in
                self?.checkNickname(nickname)
            }
            .store(in: &cancellables)
    }
    
    private func checkNickname(_ nickname: String) {
        guard nickname.count >= 4 else {
            isNicknameValid = nil
            isCheckingNickname = false
            return
        }
        isCheckingNickname = true
        isNicknameValid = nil
        
        // 아래 코드는 네트워크 호출을 가정하여 작성 checkNicknameAvailability가 비동기 네트워크 호출임
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            let result = self?.nicknameCheckingService.checkNicknameAvailability(nickname)
            
            DispatchQueue.main.async {
                self?.isCheckingNickname = false
                self?.isNicknameValid = result
            }
        }
    }

}

class NicknameCheckingServiceMock: NicknameCheckingService {

    func checkNicknameAvailability(_ nickname: String) -> Bool {
        return Int.random(in: 0...3) == 0 ? false : true // 25%의 확률로 false
    }
    
}

protocol NicknameCheckingService {
    func checkNicknameAvailability(_ nickname: String) -> Bool
}
