//
//  TrainingstagebuchÜbungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI

struct Training: View {
    @State private var gewichte: [[String]] = Array(repeating: Array(repeating: "", count: 10), count: 10)
    @State private var wiederholungen: [[String]] = Array(repeating: Array(repeating: "", count: 10), count: 10)
    @ObservedObject var selectedSplit: Split
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedUebung: Uebung?


    var body: some View {
        VStack {
            ForEach(selectedSplit.getUebungen.indices, id: \.self) { uebungIndex in
                let uebung = selectedSplit.getUebungen[uebungIndex]
                
                Section(header: Text(uebung.name ?? "")) {
                    ForEach(0..<Int(uebung.saetze), id: \.self) { saetzeIndex in
                        HStack {
                            TextField("Gewicht", text: $gewichte[uebungIndex][saetzeIndex])
                            TextField("Wiederholungen", text: $wiederholungen[uebungIndex][saetzeIndex])
                        }
                        .onChange(of: selectedUebung) { newValue in
                            if let newValue = newValue {
                                self.selectedUebung = newValue
                            }
                        }
                    }
                }
            }
            Button(action: saveTraining) {
                Text("Training abschließen")
            }
        }
    }

    func saveTraining() {
        guard gewichte.count == wiederholungen.count else {
            return
        }

        let trainingseintrag = Trainingseintrag(context: moc)
        trainingseintrag.datum = Date()
        trainingseintrag.id = UUID()

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

        presentationMode.wrappedValue.dismiss()
    }

}
