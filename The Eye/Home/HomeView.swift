//
//  HomeView.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import SwiftUI

struct HomeView: View {
    @State var didOnboarding: Bool = true
    var body: some View {
        VStack{
            Text("Hello, Home!")
        }.fullScreenCover(isPresented: $didOnboarding, content: {
            Onboarding(didOnboarding: $didOnboarding)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
