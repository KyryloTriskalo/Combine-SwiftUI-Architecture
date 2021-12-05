//
//  Chat.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 15.08.2021.
//

import Foundation

struct Chat: Codable, Identifiable {
    var id: Int
    var name: String?
    var time: Int?
    var picture: String?
    
    var description: String?

    public init(id: Int,name: String? = "", time: Int? = 0, picture: String? = "", description: String? = "") {
        self.id = id
        self.name = name
        self.time = time
        self.picture = picture
        self.description = description
    }
}
