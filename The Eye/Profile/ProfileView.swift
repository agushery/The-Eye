//
//  ProfileView.swift
//  The Eye
//
//  Created by Agus Hery on 26/04/22.
//

import SwiftUI

struct ProfileView: View {
    @State var name: String
    @State var phoneNumber: String
    @State private var enableBlogger = true
    var body: some View {
            NavigationView {
                Form {
                    Image("Profile")
                    .resizable()
                    .clipped()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2.0))
                    Section(header: Text("Basic Information")) {
                        HStack {
                            Text("First Name")
                            Spacer(minLength: 100)
                            Text("Agus")
                        }
                        HStack {
                            Text("Last Name")
                            Spacer(minLength: 100)
                            Text("Hery")
                        }
                    }
                    Section(header: Text("Additional")) {
                        HStack {
                            Text("Gender")
                            Spacer(minLength: 100)
                            Text("Male")
                        }
                        Toggle(isOn: $enableBlogger) {
                            Text("Blogger")
                        }
                    }
                }.navigationBarTitle(Text("Profile"))
            }
        }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "", phoneNumber: "")
            .previewInterfaceOrientation(.portrait)
    }
}
