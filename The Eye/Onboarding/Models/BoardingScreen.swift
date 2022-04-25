//
//  BoardingScreen.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import Foundation
import SwiftUI

struct BoardingScreen: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}

// sample model screen
var boardingScreen: [BoardingScreen] = [
    BoardingScreen(image: "Onboarding1", title: "Easy Controll with \nThe Eye", description: "Help controll and manage your finances safely and quickly"),
    BoardingScreen(image: "Onboarding2", title: "Easy Manage with \nThe Eye", description: "Help controll and manage your finances safely and quickly"),
    BoardingScreen(image: "Onboarding2", title: "Safe with \nThe Eye", description: "Help controll and manage your finances safely and quickly")
]
