//
//  Created by user on 27.02.2021.
//

import Combine
import SwiftUI

enum LogInState: String {
    case idle
    case enable
    case disable
}

//protocol LoginPresenterProtocol {
//    // Wrapped value
//    var logInState: LogInState { get }
//    // (Published property wrapper)
//    var logInStatePublished: Published<LogInState> { get }
//     // Publisher
//    var logInStatePublisher: Published<LogInState>.Publisher { get }
//}

protocol LoginViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    func buildTabBarView() -> TabBarView
}

class LoginViewModel {

    // MARK: - Public properties
    
//    @Published private(set) var logInState: LogInState = .idle
//    var logInStatePublished: Published<LogInState> { _logInState }
//    var logInStatePublisher: Published<LogInState>.Publisher { $logInState }
   
    @Published private(set) var logInState: LogInState = .idle
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - Private properties
    
    private var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { password in return Validator.validatePassword(password) }
            .eraseToAnyPublisher()
    }
    
    private var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in return Validator.validateEmail(email) }
            .eraseToAnyPublisher()
    }
    
    private var isCredentialsValidPublisher: AnyPublisher<LogInState, Never> {
        Publishers.CombineLatest(isValidPasswordPublisher, isValidEmailPublisher)
          .map { isValidEmail, isValidPassword in
            switch (isValidEmail, isValidPassword) {
                case (true, true): return .enable
                default: return .disable
            }
          }
        .eraseToAnyPublisher()
    }

    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Init

    init() {
        setupPublishers()
    }
    
    // MARK: - Private Methods

    private func setupPublishers() {
        
        isValidPasswordPublisher
            .receive(on: RunLoop.main)
            .sink { _ in }
            .store(in: &cancellableSet)
        
        isValidEmailPublisher
            .receive(on: RunLoop.main)
            .sink { _ in }
            .store(in: &cancellableSet)

        
        isCredentialsValidPublisher
            .receive(on: RunLoop.main)
            .sink { (state) in
                self.logInState = state
            }
            .store(in: &cancellableSet)
    }
   
    
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func buildTabBarView() -> TabBarView {
        let profile = ProfileView(presenter: ProfilePresenter())
        let chatsView: ChatListView = ChatListView(presenter: ChatListViewModel())
        return TabBarView(profileView: profile, chatsView: chatsView)
    }

}
