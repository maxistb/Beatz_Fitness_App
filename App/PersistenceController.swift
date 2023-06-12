//
//  PersistenceController.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 21.05.23.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "YourDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Fehler beim Laden des Core Data-Stacks: \(error.localizedDescription)")
            }
        }
    }
}
