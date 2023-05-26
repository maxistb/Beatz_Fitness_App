//
//  SplitVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI

extension SplitView {
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let split = splits[index]
            moc.delete(split)
        }
        try? moc.save()
        
    }

    func moveItems(from indices: IndexSet, to newOffset: Int) {
        var orderedSplits = splits.sorted { $0.order < $1.order }
        orderedSplits.move(fromOffsets: indices, toOffset: newOffset)

        // Update the order values of the moved splits
        for (index, split) in orderedSplits.enumerated() {
            split.order = Int64(index)
        }

        do {
            try moc.save()
        } catch {
            // Handle the error appropriately
            print("Failed to save order changes: \(error)")
        }
    }

    
    func updateSplitName(split: Split, newName: String) {
        moc.performAndWait {
            split.name = newName
            try? moc.save()
        }
    }


}
