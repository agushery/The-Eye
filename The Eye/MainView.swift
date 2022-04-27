//
//  MainView.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            StatusView()
                .tabItem{
                    Image(systemName: "menucard")
                    Text("Status")
                }
            TransactionView()
                .tabItem{
                    Image(systemName: "list.triangle")
                    Text("Transaction")
                }
            ContentView()
                .tabItem{
                    Image(systemName: "list.triangle")
                    Text("Transaction")
                }
            ProfileView(firstName: "", lastName: "", gender: "", income: "", email: "")
                .tabItem{
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
