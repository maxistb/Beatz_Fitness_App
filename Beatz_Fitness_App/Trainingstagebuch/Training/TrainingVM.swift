//
//  TrainingVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI
import CoreData

class TrainingViewModel: ObservableObject {
    @Published var gewichte: [[String]] = Array(repeating: Array(repeating: "", count: 20), count: 20)
    @Published var wiederholungen: [[String]] = Array(repeating: Array(repeating: "", count: 20), count: 20)
    let selectedSplit: Split
    let moc: NSManagedObjectContext
    var selectedUebung: Uebung?

    init(selectedSplit: Split, moc: NSManagedObjectContext) {
        self.selectedSplit = selectedSplit
        self.moc = moc
    }
    
    func saveTraining() {
        guard gewichte.count == wiederholungen.count else {
            return
        }

        let trainingseintrag = Trainingseintrag(context: moc)
        trainingseintrag.datum = Date()
        trainingseintrag.id = UUID()
        trainingseintrag.split = selectedSplit

        for (index, uebung) in selectedSplit.getUebungen.enumerated() {
            let uebungsname = uebung.name ?? ""

            for satzIndex in 0..<Int(uebung.saetze) {
                let ausgefuehrterSatz = AusgefuehrterSatz(context: moc)
                ausgefuehrterSatz.gewicht = Double(gewichte[index][satzIndex]) ?? 0.0
                ausgefuehrterSatz.wiederholungen = Int64(wiederholungen[index][satzIndex]) ?? 0
                ausgefuehrterSatz.id = UUID()
                ausgefuehrterSatz.uebungname = uebungsname

                trainingseintrag.addToAusgefuehrteUebungen(ausgefuehrterSatz)
            }
        }

        do {
            try moc.save()
        } catch {
            print("Error saving trainingseinheit: \(error.localizedDescription)")
        }
    }
}
