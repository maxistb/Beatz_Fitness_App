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

    func moveItems(indices: IndexSet, newOffset: Int) {
          splitArray.move(fromOffsets: indices, toOffset: newOffset) // Verschieben der Elemente in der separaten Kopie
          
          // Aktualisieren der Reihenfolge in der uebungenArray-Kopie
          for (index, split) in splitArray.enumerated() {
              split.order = Int64(index)
          }
          
          try? moc.save() // Speichern der Änderungen im moc
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
