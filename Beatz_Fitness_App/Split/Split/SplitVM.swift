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
        var updatedIndices = indices

        let splitsToUpdate = splits.enumerated()
            .filter { updatedIndices.contains($0.offset) }
            .map { $0.element }

        for split in splitsToUpdate {
            split.order = Int64(splits.firstIndex(of: split) ?? 0)
        }

        try? moc.save()
    }

    
    func updateSplitName(split: Split, newName: String) {
        moc.performAndWait {
            split.name = newName
            try? moc.save()
        }
    }
}
