//
//  UebungVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI

extension UebungView {
    func deleteItems(at offsets: IndexSet) {
        let sortedOffsets = offsets.sorted(by: >)
        
        let uebungenToDelete = split.getUebungen.enumerated().compactMap { (index, uebung) in
            return sortedOffsets.contains(index) ? uebung : nil
        }
        
        uebungenToDelete.forEach { uebung in
            moc.delete(uebung)
        }
        
        for (index, uebung) in split.getUebungen.enumerated() {
            if uebung.order > Int64(sortedOffsets.count - 1) {
                uebung.order -= Int64(sortedOffsets.count)
            }
        }
        
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }

        
    //     MARK: - Funktionierende MoveItems
    
    func moveItems(from indices: IndexSet, to newOffset: Int) {
        let sortedUebungen = split.getUebungen.sorted { $0.order < $1.order }
        
        var newUebungen = Array(sortedUebungen)
        newUebungen.move(fromOffsets: indices, toOffset: newOffset)
        
        // Aktualisiere die "order" für die verschobenen Elemente
        for (index, uebung) in newUebungen.enumerated() {
            uebung.order = Int64(index)
            print("Index: \(index)")
            print("\(uebung.name) \(uebung.order)")
        }
        
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }

    
    // MARK: - Test MoveItems
    
    //    func moveItems(indices: IndexSet, newOffset: Int) {
    //        uebungenArray.move(fromOffsets: indices, toOffset: newOffset)
    //        for (index, uebung) in uebungenArray.enumerated() {
    //            uebung.order = Int64(index)
    //        }
    //        try? moc.save()
    //    }
    
    
    
    //    func moveItems(from source: IndexSet, to destination: Int) {
    //           // Get the exercises within the current split
    //           let splitExercises = split.uebung?.allObjects as? [Uebung] ?? []
    //
    //           // Filter the exercises based on the source index set
    //           let filteredExercises = splitExercises.filter { source.contains(Int($0.order)) }
    //
    //           // Calculate the adjusted destination index
    //           var adjustedDestination = destination
    //           if destination > source.first! {
    //               adjustedDestination -= source.count
    //           }
    //        if destination < source.first! {
    //            adjustedDestination += source.count
    //        }
    //
    //           // Move the filtered exercises to the adjusted destination index
    //           for exercise in filteredExercises {
    //               exercise.order = Int64(adjustedDestination)
    //               adjustedDestination += 1
    //           }
    //
    //           try? moc.save()
    //       }
    
    
    
    //        func moveItems(at sets: IndexSet, destination: Int) {
    //            let itemToMove = sets.first!
    //
    //            if itemToMove < destination {
    //                var startIndex = itemToMove + 1
    //                let endIndex = destination - 1
    //                var startOrder = uebungen[itemToMove].order
    //                while startIndex <= endIndex {
    //                    uebungen[startIndex].order = startOrder
    //                    startOrder += 1
    //                    startIndex += 1
    //                }
    //                uebungen[itemToMove].order = startOrder
    //            }
    //            else if destination < itemToMove {
    //                var startIndex = destination
    //                let endIndex = itemToMove - 1
    //                var startOrder = uebungen[destination].order + 1
    //                let newOrder = uebungen[destination].order
    //                while startIndex <= endIndex {
    //                    uebungen[startIndex].order = startOrder
    //                    startOrder += 1
    //                    startIndex += 1
    //                }
    //                uebungen[itemToMove].order = newOrder
    //                print("Item: \(itemToMove) NewOrder: \(newOrder) StartOrder: \(startOrder) StartIndex: \(startIndex) Endindex: \(endIndex)")
    //            }
    //            do {
    //                try moc.save()
    //            }
    //            catch {
    //                print(error.localizedDescription)
    //            }
    //        }
}
