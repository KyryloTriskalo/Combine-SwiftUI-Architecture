//
//  ChatRowCell.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 15.08.2021.
//

import Foundation
import SwiftUI

struct ChatCell : View {
    
    var model: Chat
    
    var body: some View {
        
        HStack(spacing: 12){
            Image(model.picture ?? "p1")
            .resizable()
            .frame(width: 55, height: 55)
            VStack(alignment: .leading, spacing: 12) {
                Text(model.name ?? "")
                Text(model.description ?? "")
                    .font(.caption)
            }
            Spacer()
            VStack{
                Spacer()
                Text("\( Date(timeInterval: TimeInterval(model.time ?? 0), since: Date()).toString(format: "HH:MM"))")
                Spacer()
            }
        }.padding(.vertical)
        
    }
}




struct ChatCell_Preview : PreviewProvider {
    
    static var model: Chat = Chat(id: 123, name: "Kyrylo", time: 1231254325, picture: "p7", description: "Чат с моими сохраненками")
    
    static var previews: some View {
        
        HStack(spacing: 12){
            Image(model.picture ?? "p1")
            .resizable()
            .frame(width: 55, height: 55)
            VStack(alignment: .leading, spacing: 12) {
                Text(model.name ?? "")
                Text(model.description ?? "").font(.caption)
            }
            Spacer()
            VStack{
                Spacer()
                Text("\( Date(timeInterval: TimeInterval(model.time ?? 0), since: Date()).toString(format: "HH:MM"))")
                Spacer()
            }
        }.padding(.vertical)
        
    }
}
