//
//  Created by user on 27.02.2021.
//

import SwiftUI
import Combine

struct TabBarView: View {

    private(set) var profileView: ProfileView<ProfilePresenter>
    private(set) var chatsView: ChatListView

    var body: some View {
        
        TabView {
            NavigationView {
                profileView
                    .navigationTitle("Profile")
                    .navigationBarItems(trailing: EditButton(presenter: profileView.presenter))
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .tabItem {
                Text("Profile")
            }
            
            chatsView
                .tabItem {
                    Text("Chats")
                }
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}
