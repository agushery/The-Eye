//
//  The_EyeApp.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import SwiftUI

@main
struct The_EyeApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
