//
//  StatusView.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import SwiftUI

struct StatusView: View {
    @State var didOnboarding: Bool = true
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("Welcome Agus")
                        .fontWeight(.bold)
                        .kerning(1.2)
                        .padding()
                    Spacer()
                    NavigationLink(destination: ProfileView(income: "")){
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .padding(.trailing,25)
                    } //navlink
                } // hastack
                Spacer()
            } // Vstak 1
            .fullScreenCover(isPresented: $didOnboarding, content: {
                Onboarding(didOnboarding: $didOnboarding)
            })
            .navigationTitle("Status")
        } // navView
    } // var body
} // struct

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
