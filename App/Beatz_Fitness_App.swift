//
//  VideoCoreDataApp.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI

@main
struct Beatz_Fitness_App: App {
    
    @StateObject private var dataController = DataController(name: "Model")
    
    var body: some Scene {
        WindowGroup {
            Hauptbildschirm()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
