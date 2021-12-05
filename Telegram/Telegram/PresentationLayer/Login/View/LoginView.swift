//
//  Created by user on 27.02.2021.
//

import SwiftUI
import Combine

struct LoginView: View {

    @ObservedObject var presenter: LoginViewModel

    init(presenter: LoginViewModel) {
        self.presenter = presenter
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HelloText()
                    UserImage()
                    UsernameTextField(username: $presenter.email)
                    PasswordSecureField(password: $presenter.password)
                    NavigationLink(destination: presenter.buildTabBarView()) { Text("Log In") }
                    .isHidden(presenter.logInState != .enable)
                }
                .padding()
            }
        }
    }
}
