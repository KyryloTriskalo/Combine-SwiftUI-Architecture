//
//  ChatListView.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 15.08.2021.
//

import SwiftUI
import Combine

struct ChatListView: View {
    
    @ObservedObject var presenter: ChatListViewModel
    @State var changes: Int = 0
    
    init(presenter: ChatListViewModel) {
        self.presenter = presenter
    }
    
    var body: some View {
        NavigationView {
            List(self.presenter.chatList, id: \.id) { model in
                NavigationLink(destination: ChatView<ChatViewModel>(viewModel: ChatViewModel(chatId: model.id))) {
                    ChatCell(model: model)
                }
            }
            .navigationTitle(changes == 0 ? "Chats" : "Chats were edited \(changes) times" )
            .onAppear(perform: {
                self.changes = self.presenter.changesCount()
                self.presenter.getChatList()
            })
        }
    }
}
