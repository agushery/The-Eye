//
//  DataController.swift
//  The Eye
//
//  Created by Agus Hery on 28/04/22.
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "The_Eye")

        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                print("Error gus")
                fatalError("Unresolve Error: \(error)")
            }
        }
    }
}
