//
//  ProfileView.swift
//  The Eye
//
//  Created by Agus Hery on 26/04/22.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) var mov
    @State var firstName: String = ""
    @State var lastName: String
    @State var gender: String
    @State var income: String
    @State var email: String
    
    let genders = ["Male", "Female"]
    
    
    var body: some View {
        NavigationView {
            Form {
                Image("Profile")
                    .resizable()
                    .clipped()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2.0))
                Section(header: Text("Name")) {
                    HStack {
                        NavigationLink {
                            Form {
                                VStack{
                                    HStack {
                                        Text("First Name ")
                                        TextField("Enter First Name", text: $firstName)
                                            .padding(.leading,50)
                                    }
                                    HStack {
                                        Text("Last Name ")
                                        TextField("Enter Last Name", text: $lastName)
                                            .padding(.leading,50)
                                    }
                                }
                            }
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
                            }
                        }label: {
                            Text(firstName + lastName)
                        }
                    }
                }
                Section(header: Text("Addtitional")){
                    HStack {
                        Text("Date of Birth")
                        TextField("Cek Date Picker", text: $lastName)
                    }
                    HStack {
                        Picker("Gender", selection: $gender){
                            ForEach(genders, id: \.self){
                                Text($0)
                            }
                        }
                    }
                }
                Section(header: Text("Contactable At")) {
                    HStack {
                        Text("Email")
                        TextField("Enter Email", text: $email)
                            .padding(.leading, 166)
                    }
                    HStack {
                        Text("Income")
                        TextField("Enter Income", text: $income)
                            .padding(.leading, 150)
                    }
                }
                
            }
            .navigationBarTitle(Text("Profile"))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(firstName: "", lastName: "", gender: "", income: "", email: "")
            .previewInterfaceOrientation(.portrait)
    }
}
