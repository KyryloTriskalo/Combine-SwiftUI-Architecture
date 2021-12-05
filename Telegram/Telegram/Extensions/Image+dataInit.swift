//
//  Image.swift
//  Messenger
//
//  Created by Кирилл Трискало on 23.08.2020.
//  Copyright © 2020 Кирилл Трискало. All rights reserved.
//

import Foundation
import SwiftUI

extension Image {

    public init(data: Data?, placeholder: String = "user") {
        guard let data = data,
          let uiImage = UIImage(data: data) else {
            self = Image(placeholder)
            return
        }
        self = Image(uiImage: uiImage)
    }
}
