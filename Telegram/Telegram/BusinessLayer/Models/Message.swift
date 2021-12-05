//
//  Message.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 15.08.2021.
//

import Foundation

struct Message: Codable, Identifiable {
    var id: UUID? = UUID()
    var chatUid: String?
    var text: String?
    var dataAndTimeInString: String = ""
    var dateAndTime: Date? {
          didSet {
              dataAndTimeInString = dateFormatter(date: dateAndTime ?? Date())
          }
      }
    var image: Data?
    var isUnread: Bool?
    var isLoading: Bool?
    var isGroupChat: Bool?
    var user: User?

    
    public init(chatUid: String? = "", text: String? = "", dateAndTime: Date = Date(), image: Data? = nil, isUnread: Bool = false, isLoading: Bool = false, isGroupChat: Bool = false, user: User? = nil) {
//        self.id = id
        self.chatUid = chatUid
        self.text = text
        self.dateAndTime = dateAndTime
        self.image = image
        self.isUnread = isUnread
        self.isLoading = isLoading
        self.user = user
        self.isGroupChat = isGroupChat
        setDateAndTime(date: dateAndTime)
    }
    
    mutating func setDateAndTime(date: Date) {
        self.dateAndTime = date
    }
    
    func isSignInUser() -> Bool {
        return self.user?.uid == SignInUser.uid
    }
        
    func dateFormatter(date: Date) -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = "HH:mm:ss"
       return formatter.string(from: date)
    }
}
