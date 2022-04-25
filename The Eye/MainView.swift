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
            HomeView()
                .tabItem{
                    Image(systemName: "menucard")
                    Text("Chart")
                }
            ContentView()
                .tabItem{
                    Image(systemName: "chart.xyaxis.line")
                    Text("Chart")
                }
        }
    }
}
