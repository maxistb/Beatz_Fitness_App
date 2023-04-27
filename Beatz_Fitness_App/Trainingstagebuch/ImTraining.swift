//
//  TrainingstagebuchÜbungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI

struct Training: View {
    @State private var gewichte: [String] = Array(repeating: "", count: 10)
    @State private var wiederholungen: [String] = Array(repeating: "", count: 10)
    @ObservedObject var selectedSplit: Split
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            ForEach(selectedSplit.getUebungen) { uebung in
                Section(header: Text(uebung.name ?? "")) {
                    ForEach(0..<Int(uebung.saetze)) { saetzeIndex in
                        HStack {
                            TextField("Gewicht", text: $gewichte[saetzeIndex])
                            TextField("Wiederholungen", text: $wiederholungen[saetzeIndex])
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
        for index in 0..<gewichte.count {
            if let gewicht = Double(gewichte[index]), let wiederholungen = Int(wiederholungen[index]) {
                let trainingseintrag = Trainingseintrag(context: moc)
                trainingseintrag.datum = Date()
                trainingseintrag.gewicht = gewicht
                trainingseintrag.wiederholungen = Int64(wiederholungen)
                trainingseintrag.id = UUID()
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
