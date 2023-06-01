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
            if UserDefaults.standard.bool(forKey: "isFirstLaunch") {
                WelcomeView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .onAppear {
                        UserDefaults.standard.set(false, forKey: "isFirstLaunch")
                    }
            } else {
                Hauptbildschirm()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}
