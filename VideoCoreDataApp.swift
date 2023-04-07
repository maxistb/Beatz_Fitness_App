//
//  VideoCoreDataApp.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI

@main
struct VideoCoreDataApp: App {
    
    @StateObject private var dataController = DataController(name: "Model")
    
    var body: some Scene {
        WindowGroup {
            SplitView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
