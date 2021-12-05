//
//  ChatsPresenter.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 15.08.2021.
//

import Combine
import SwiftUI
import Resolver


protocol ChatListViewModelProtocol: ObservableObject {
    func changesCount() -> Int 
}

class ChatListViewModel: ChatListViewModelProtocol {

    @Injected var chatService: ChatService 
    @Published var chatList: [Chat] = []
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {}
}

// MARK: - Networking Methods

extension ChatListViewModel {

    func changesCount() -> Int {
        return chatService.changesCount
    }
    
    func getChatList() {
        chatService.getChatList(endPoint: RequestItemsType.getChatList)
            .sink { (response) in
                switch response {
                case .finished:
                    print("🔥 chatlist success")
                case .failure(let error):
                    print("☠️ chatlist error = \(error)")
                }
            } receiveValue: { [weak self] (chatList) in
                guard let self = self else { return }
                self.chatList = chatList
            }
            .store(in: &cancellableSet)
    }
}
