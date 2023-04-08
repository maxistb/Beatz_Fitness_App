//
//  DataController.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    var container: NSPersistentContainer
    
    init(name: String) {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("CoreData Error: \(error)")
            }
        }
    }
}
