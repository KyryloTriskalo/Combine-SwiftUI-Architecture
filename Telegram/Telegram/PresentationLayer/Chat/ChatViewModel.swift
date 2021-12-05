//
//  ChatViewModel.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 29.08.2021.
//

import SwiftUI
import Combine
import Resolver


protocol ChatViewModelProtocol: ObservableObject {
    var chatName: String { get set }
    var chatDescription: String { get set }
    var chatPictureName: String { get set }
    func getChat()
    func saveChat()
    func removeChat()
    func increaseChangesCount()
}

class ChatViewModel: ChatViewModelProtocol {

    @Injected var chatService: ChatService 
    private var cancellableSet: Set<AnyCancellable> = []
    private(set) var chatId: Int
        
    @Published var chatName: String = ""
    @Published var chatDescription: String = ""
    @Published var chatPictureName: String = "placeholder"
    
    private var chatNamePublisher: AnyPublisher<String,Never> {
        $chatName.eraseToAnyPublisher()
    }
    private var chatDescriptionPublisher: AnyPublisher<String,Never> {
        $chatDescription.eraseToAnyPublisher()
    }
    
    init(chatId: Int) {
        self.chatId = chatId
        chatNamePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { text in self.chatName = text })
            .store(in: &cancellableSet)
        chatDescriptionPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { text in self.chatDescription = text })
            .store(in: &cancellableSet)
    }
    
    private func assembleData() -> Chat {
        return Chat(id: chatId, name: chatName, time: Int.random(in: 10000000...100000000), picture: chatPictureName, description: chatDescription)
    }
    
    
}

// MARK: - Networking Methods

extension ChatViewModel {
    
    func increaseChangesCount()  {
        chatService.changesCount += 1
    }
    
    func getChat() {
        chatService.getChat(endPoint: RequestItemsType.getChat(id: chatId))
            .sink { (response) in
                switch response {
                case .finished:
                    print("🔥 get chat success")
                case .failure(let error):
                    print("☠️ get chat error = \(error)")
                }
            } receiveValue: { [weak self] (chat) in
                guard let self = self else { return }
                self.chatName = chat.name ?? ""
                self.chatDescription = chat.description ?? ""
                self.chatPictureName = chat.picture ?? ""
            }
            .store(in: &cancellableSet)
    }
    
    func removeChat() {
        chatService.removeChat(endPoint: RequestItemsType.removeChat(id: chatId))
            .sink { (response) in
                switch response {
                case .finished:
                    print("🔥 chat successfully removed")
                case .failure(let error):
                    print("☠️ chat removing error = \(error)")
                }
            }
            receiveValue: { _ in }
            .store(in: &cancellableSet)
    }
    
    func saveChat() {
        chatService.postChat(endPoint: RequestItemsType.patchChat(id: chatId), data: assembleData())
            .sink { (response) in
                switch response {
                case .finished:
                    print("🔥 patch chat success")
                case .failure(let error):
                    print("☠️ patch chat error = \(error)")
                }
            } receiveValue: { _ in }
            .store(in: &cancellableSet)
    }

}
