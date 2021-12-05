//
//  Created by user on 27.02.2021.
//

import Combine
import SwiftUI
import Resolver

protocol ProfilePresenting: ObservableObject {
    var isEditMode: Bool { get set }
    var isFormValid: Bool { get set }

    var stateColor: Color { get }
    var editButtonText: String { get }
    
    var phone: String { get set }
    var email: String { get set }
    var bio: String { get set }
    var phoneValidationColor: Color { get }
    var emailValidationColor: Color { get }
    var bioValidationColor: Color { get }
    
    func getUser()
    func updateUser()
}

final class ProfilePresenter: ProfilePresenting {
        
    // MARK: - Public properties

    @Published var isEditMode = false
    @Published var isFormValid = true
    
    @Published var isEditButtonEnable = true
    @Published var editButtonText: String = EditButtonText.edit
    
    @Published var phone: String = "380955777275"
    @Published var email: String = "capx9@gm.com"
    @Published var bio: String = "12312"
    
    @Published var stateColor: Color = Color.gray
    @Published var phoneValidationColor: Color = Color.black
    @Published var emailValidationColor: Color = Color.black
    @Published var bioValidationColor: Color = Color.black
    
    // MARK: - Private properties

    private var editModePublisher: AnyPublisher<Bool, Never> {
        $isEditMode
            .eraseToAnyPublisher()
    }
    
    private var isValidPhonePublisher: AnyPublisher<Bool, Never> {
        $phone
            .map { phone in return Validator.validatePhoneField(phone) }
            .eraseToAnyPublisher()
    }
    
    private var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in return Validator.validateEmail(email) }
            .eraseToAnyPublisher()
    }
    
    private var isValidBioPublisher: AnyPublisher<Bool, Never> {
        $bio
            .map { bio in return bio != "" }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isValidPhonePublisher, isValidEmailPublisher, isValidBioPublisher)
          .map { isValipPhone, isValidEmail, isValidBio in
            switch (isValipPhone,isValidEmail, isValidBio) {
                case (true, true, true): return true
                default: return false
            }
          }
        .eraseToAnyPublisher()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    @Injected private var profileService: UserService

    // MARK: - Init
    
    init() {
        setupPublishers()
    }
    
    // MARK: - Private Methods

    private func setupPublishers() {
        editModePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (_) in
                switch self.isEditMode {
                case true: self.stateColor = .green; self.editButtonText = EditButtonText.save
                case false: self.stateColor = .gray; self.editButtonText = EditButtonText.edit
                }
            })
            .store(in: &cancellableSet)
        
        isValidPhonePublisher
            .receive(on: RunLoop.main)
            .sink { (isValid) in
                switch isValid {
                case true: self.phoneValidationColor = .black
                case false: self.phoneValidationColor = .red
                }
            }
            .store(in: &cancellableSet)
        
        isValidEmailPublisher
            .receive(on: RunLoop.main)
            .sink { (isValid) in
                switch isValid {
                case true: self.emailValidationColor = .black
                case false: self.emailValidationColor = .red
                }
            }
            .store(in: &cancellableSet)
        
        isValidBioPublisher
            .receive(on: RunLoop.main)
            .sink { (isValid) in
                switch isValid {
                case true: self.bioValidationColor = .black
                case false: self.bioValidationColor = .red
                }
            }
            .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .sink { (isValid) in
                self.isFormValid = isValid
            }
            .store(in: &cancellableSet)
    }
}

// MARK: - Networking Methods

extension ProfilePresenter {

    func getUser() {
        profileService.getProfile(endPoint: RequestItemsType.getUser)
            .sink { (response) in
                switch response {
                case .finished:
                    print("🔥 get user  success")
                case .failure(let error):
                    print("☠️ get error = \(error)")
                }
            } receiveValue: { (user) in
                DispatchQueue.main.async {
                    self.phone = user.phone
                    self.email = user.email
                    self.bio = user.bio
                }
            }
            .store(in: &cancellableSet)
    }
    
    func updateUser() {
        let data = User(id: 21, name: "Caroline", phone: phone, email: email, bio: bio)
        profileService.postProfile(endPoint: RequestItemsType.updateUser, data: data)
            .sink { (response) in
                switch response {
                case .finished:
                    print( "🔥 update user success")
                case .failure(let error):
                    print("☠️ put error = \(error)")
                }
                } receiveValue: { (user) in
                    print("changed user looks like = \(user)")
                }
            .store(in: &cancellableSet)
    }
}
