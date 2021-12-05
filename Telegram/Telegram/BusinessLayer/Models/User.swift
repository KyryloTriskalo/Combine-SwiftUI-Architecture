//
//  User.swift
//  Telegram
//
//  Created by user on 06.03.2021.
//

import Foundation

struct User: Codable {
    var id: Int
    var uid: String?

    var name: String
    var phone: String
    var email: String
    var bio: String
    var surname: String?

    var image: Data?

    
    init(id: Int = 0, uid: String? = "", name: String = "", surname: String? = "", phone: String = "", email: String = "", bio: String = "", image: Data? = nil) {
        self.id = id
        self.uid = uid
        self.name = name
        self.surname = surname
        self.phone = phone
        self.email = email
        self.bio = bio

        self.image = image
        
    }
}


