//
//  VordefinierteSplitsVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.05.23.
//

import SwiftUI


struct VordefinierteSplits {
    let name: String
    let uebungen: [UebungsItem]
}

extension VordefinierteSplitView {
    func createNewSplit() {
        let newOrder = (try? moc.fetch(Split.fetchRequest()).count) ?? 0
        let neuerSplit = Split(context: moc)
        neuerSplit.name = split.name
        neuerSplit.order = Int64(newOrder)
        print("Order Split: \(newOrder)")

        
        for uebung in split.uebungen {
            let neueUebung = Uebung(context: moc)
            neueUebung.id = UUID()
            neueUebung.name = uebung.uebungName
            neueUebung.saetze = Int64(uebung.anzahlSaetze)
            neueUebung.notizen = ""
            let newOrder = (neuerSplit.uebung?.count ?? 0)
            neueUebung.order = Int64(newOrder)
//                        print("Order Übung: \(newOrder)")

            neuerSplit.addToUebung(neueUebung)
        }
        
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}
