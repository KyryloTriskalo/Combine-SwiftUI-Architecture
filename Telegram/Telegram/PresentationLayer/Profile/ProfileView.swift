//
//  Created by user on 27.02.2021.
//

import SwiftUI
import Combine

struct ProfileView<T: ProfilePresenting>: View {
    
    @ObservedObject var presenter: T
    
    init(presenter: T) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack {
            ProfileAvatar(presenter: presenter)
            ProfileForm(presenter: presenter)
        }.onAppear(perform: {
            self.presenter.getUser()
        })
        .environment(\.colorScheme, .light)
    }
    
}

