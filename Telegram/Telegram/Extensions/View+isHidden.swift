//
//  View+isHedden.swift
//  Messenger
//
//  Created by Кирилл Трискало on 23.08.2020.
//  Copyright © 2020 Кирилл Трискало. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
