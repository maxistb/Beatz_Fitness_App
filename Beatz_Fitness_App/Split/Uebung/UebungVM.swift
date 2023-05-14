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
    func moveItems(from source: IndexSet, to destination: Int) {
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Uebung.order, ascending: true)]) var uebungen: FetchedResults<Uebung>
        // Save changes to Core Data
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }
}
