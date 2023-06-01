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

    func moveItems(from source: IndexSet, to destination: Int) {
        var revisedSplits: [Split] = splits.map { $0 }
        revisedSplits.move(fromOffsets: source, toOffset: destination)
        
        // Update the order property of the splits based on their new positions
        for index in 0..<revisedSplits.count {
            revisedSplits[index].order = Int64(index)
        }
        
        // Save the changes to the managed object context
        for split in revisedSplits {
            moc.performAndWait {
                split.order = split.order // Trigger change notification
            }
        }
        try? moc.save()
    }

    
//    func moveItems(at sets: IndexSet, destination: Int) {
//        let itemToMove = sets.first!
//
//        if itemToMove < destination {
//            var startIndex = itemToMove + 1
//            let endIndex = destination - 1
//            var startOrder = splits[itemToMove].order
//            while startIndex <= endIndex {
//                splits[startIndex].order = startOrder
//                startOrder += 1
//                startIndex += 1
//            }
//            splits[itemToMove].order = startOrder
//        }
//        else if destination < itemToMove {
//            var startIndex = destination
//            let endIndex = itemToMove - 1
//            var startOrder = splits[destination].order + 1
//            let newOrder = splits[destination].order
//            while startIndex <= endIndex {
//                splits[startIndex].order = startOrder
//                startOrder += 1
//                startIndex += 1
//            }
//            splits[itemToMove].order = newOrder
//        }
//        do {
//            try moc.save()
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
    


    func updateSplitName(split: Split, newName: String) {
        moc.performAndWait {
            split.name = newName
            try? moc.save()
        }
    }
}
