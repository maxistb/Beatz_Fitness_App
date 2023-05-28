//
//  UebungVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI

extension UebungView {
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let uebung = split.getUebungen[index]
            moc.delete(uebung)
        }
        try? moc.save()
    }
    
    func moveItems(from indices: IndexSet, to newOffset: Int) {
        let sortedUebungen = uebungen.sorted { $0.order < $1.order }

        var newUebungen = Array(sortedUebungen)
        newUebungen.move(fromOffsets: indices, toOffset: newOffset)

        // Aktualisiere die "order" für die verschobenen Elemente
        for (index, uebung) in newUebungen.enumerated() {
            uebung.order = Int64(index)
        }

        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }

}
