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
    var body: some View {
        NavigationView {
            VStack{
                Image("Profile")
                    .frame(minWidth: 50, minHeight: 50)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.top,30)
                    .padding(.bottom,50)
                //
                HStack(alignment: .center){
                    Text("Name : ")
                        .font(.callout)
                        .bold()
                        .frame(alignment: .leading)
                    TextField("Enter username...", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.leading)
                .padding(.trailing)
                //
                
                HStack(alignment: .center){
                    Text("Phone Number : ")
                        .font(.callout)
                        .bold()
                        .frame(alignment: .leading)
                    TextField("Number only...", text: $phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding(.leading)
                .padding(.trailing)
                
                //
                Spacer()
                
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "", phoneNumber: "")
            .previewInterfaceOrientation(.portrait)
    }
}
