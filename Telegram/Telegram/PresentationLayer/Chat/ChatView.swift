//
//  ChatView.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 29.08.2021.
//

import SwiftUI

enum PictureState {
    case idle, genereted
}

struct ChatView<T: ChatViewModelProtocol>: View {
    
    @ObservedObject var viewModel: T
    @State private var pictureState: PictureState = .idle

    var body: some View {
     
     VStack(spacing: 0) {
             Form {
                 HStack(alignment: .center) {
                     VStack(spacing: 20) {
                        Image(viewModel.chatPictureName)
                            .resizable()
                            .frame(width: 120, height: 120, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                         Button(action: {
                             self.pictureState = .genereted
                             self.viewModel.chatPictureName = "p\(Int.random(in: 1...7))"
                         }, label: {
                             Text(pictureState == .idle  ? "Set Image" : "Set another")
                                 .foregroundColor(pictureState == .idle ? Color.green : Color.orange)
                         })
                         
                        TextField("Name", text: $viewModel.chatName)
                             .textFieldStyle(MyTextFieldStyle())
                         TextField("Description", text: $viewModel.chatDescription)
                             .textFieldStyle(MyTextFieldStyle())
                 
                     }
                 }
             }
    
             Form {
                 HStack(alignment: .center) {
                         Spacer()
                         VStack(spacing: 20) {
                             Button(action: {
                                self.viewModel.increaseChangesCount()
                                self.viewModel.saveChat()
                             }, label: {
                                 Text("Save")
                                     .foregroundColor(Color.green)
                             })
                         }
                         Spacer()
                 }
                 HStack(alignment: .center) {
                         Spacer()
                         VStack(spacing: 20) {
                             Button(action: {
                                self.viewModel.removeChat()
                             }, label: {
                                 Text("Remove")
                                     .foregroundColor(Color.red)
                             })
                         }
                         Spacer()
                 }
             }
        
         }.onAppear(perform: {
            self.viewModel.getChat()
         })
    }
}

struct ChatView_Preview: PreviewProvider {
    
    @ObservedObject static var viewModel: ChatViewModel  = ChatViewModel(chatId: 1)
    @State private static var pictureState: PictureState = .idle

   static var previews: some View {
    
    VStack(spacing: 0) {
        Form {
            HStack(alignment: .center) {
                VStack(spacing: 20) {
                    Image(pictureState == .idle ? "p3" : String("p5"))
                       .resizable()
                       .frame(width: 120, height: 120, alignment: .center)
                       .aspectRatio(contentMode: .fit)
                       .clipShape(Circle())
                    Button(action: {
                        self.pictureState = .genereted
                    }, label: {
                        Text(pictureState == .idle  ? "Set Image" : "Set another")
                            .foregroundColor(pictureState == .idle ? Color.green : Color.orange)
                    })
                    
                    TextField("Name", text: $viewModel.chatName)
                        .textFieldStyle(MyTextFieldStyle())
                    TextField("Description", text: $viewModel.chatDescription)
                        .textFieldStyle(MyTextFieldStyle())
            
                }
            }
        }
    
        Form {
            HStack(alignment: .center) {
                    Spacer()
                    VStack(spacing: 20) {
                        Button(action: {

                        }, label: {
                            Text("Save")
                                .foregroundColor(Color.green)
                        })
                    }
                    Spacer()
            }
            HStack(alignment: .center) {
                    Spacer()
                    VStack(spacing: 20) {
                        Button(action: {

                        }, label: {
                            Text("Remove")
                                .foregroundColor(Color.red)
                        })
                    }
                    Spacer()
            }
        }
      }.onAppear(perform: {
        self.viewModel.getChat()
     })
   }

}
