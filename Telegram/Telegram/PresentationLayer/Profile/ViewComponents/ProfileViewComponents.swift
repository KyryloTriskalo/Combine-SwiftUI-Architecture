//
//  ProfileEditButton.swift
//  Telegram
//
//  Created by user on 06.03.2021.
//

import SwiftUI

struct ProfileAvatar<T: ProfilePresenting>: View  {
    
    @ObservedObject var presenter: T

    init (presenter: T) {
        self.presenter = presenter
    }
    var body: some View {

    Image("p3")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 150, height: 150)
        .clipped()
        .cornerRadius(150)
        .shadow(radius: 3)
        
        Text("Caroline")
        .font(.title)
        .fontWeight(.medium)
    }
}
    
enum EditButtonText {
    static let edit = "Edit"
    static let save = "Save"
}

struct EditButton<T: ProfilePresenting>: View  {
    
    @ObservedObject var presenter: T

    init (presenter: T) {
        self.presenter = presenter
    }
     
    var body: some View {
        Button(presenter.editButtonText) {
            presenter.isEditMode = !presenter.isEditMode
            if presenter.editButtonText == EditButtonText.save {
                presenter.updateUser()
            }
        }
        .foregroundColor(presenter.isFormValid ? presenter.stateColor : .gray)
        .disabled(!presenter.isFormValid)
    }
}

struct ProfileForm<T: ProfilePresenting>: View  {
    @ObservedObject var presenter: T

    init(presenter: T) {
        self.presenter = presenter
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Phone").foregroundColor(presenter.isEditMode ? presenter.stateColor : Color.init(UIColor.darkGray.cgColor))
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("38 095 577 72 77", text: $presenter.phone)
                        .foregroundColor(presenter.isEditMode ? presenter.phoneValidationColor : Color.gray)
                        .disabled(!presenter.isEditMode)
                }
                HStack {
                    Text("Email").foregroundColor(presenter.isEditMode ? presenter.stateColor : Color.init(UIColor.darkGray.cgColor))
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("capitanx9@gmail.com", text: $presenter.email)
                        .foregroundColor(presenter.isEditMode ? presenter.emailValidationColor: Color.gray)
                        .disabled(!presenter.isEditMode)
                }
                HStack {
                    Text("Bio").foregroundColor(presenter.isEditMode ? presenter.stateColor : Color.init(UIColor.darkGray.cgColor))
                        .fontWeight(.semibold)
                    Spacer()
                    TextField("About me", text: $presenter.bio)
                        .foregroundColor(presenter.isEditMode ? presenter.bioValidationColor : Color.gray)
                        .disabled(!presenter.isEditMode)
                }
            }
        }
    }
}
