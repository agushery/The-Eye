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
            ForecastingView()
                .tabItem{
                    Image(systemName: "chart.xyaxis.line")
                    Text("Forecasting")
                }
            TransactionView()
                .tabItem{
                    Image(systemName: "list.triangle")
                    Text("Transaction")
                }
        }
        .navigationViewStyle(.stack)
    }
}
