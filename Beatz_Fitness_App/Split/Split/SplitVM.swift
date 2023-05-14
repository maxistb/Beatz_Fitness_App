//
//  SplitVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI

extension SplitView {
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            let split = splits[offset]
            moc.delete(split)
        }
        try? moc.save()
    }
    
    
    func moveItems(from source: IndexSet, to destination: Int) {
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Split.order, ascending: true)]) var splits: FetchedResults<Split>
        
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }
}
