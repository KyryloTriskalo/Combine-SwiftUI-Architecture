//
//  iFLetSwiftUI.swift
//  Messenger
//
//  Created by Кирилл Трискало on 24.08.2020.
//  Copyright © 2020 Кирилл Трискало. All rights reserved.
//

import Foundation
import SwiftUI

struct IfLet<T, Out: View>: View {
  let value: T?
  let produce: (T) -> Out

  init(_ value: T?, produce: @escaping (T) -> Out) {
    self.value = value
    self.produce = produce
  }

  var body: some View {
    Group {
      if value != nil {
        produce(value!)
      }
    }
  }
}
