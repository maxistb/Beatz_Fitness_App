//
//  TrainingstagebuchÜbungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI

//
//  TrainingstagebuchÜbungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//


import SwiftUI

struct Training: View {
    @ObservedObject var selectedSplit: Split
    @Environment(\.managedObjectContext) var moc
    @State private var textFields: [CustomTextField] = [] // array of custom textfields
    @State private var currentUebung: Uebung? // current exercise
    
    var body: some View {
        List {
            ForEach(selectedSplit.getUebungen) { uebung in
                Section(header: Text(uebung.name ?? "")) {
                    ForEach(0..<Int(uebung.saetze)) { saetzeIndex in
                            CustomTextField(satzIndex: saetzeIndex, uebung: uebung)
                        
                    }
                    Button(action: {
                        currentUebung = uebung
                        let newIndex = textFields.count
                        textFields.append(CustomTextField(satzIndex: newIndex, uebung: uebung))
                    }, label: {
                        Label("Satz Hinzufügen", systemImage: "plus")
                    })
                }
            }
        }
        .navigationTitle("Trainingstagebuch")
        .onAppear {
            for uebung in selectedSplit.getUebungen {
                for satzIndex in 0..<Int(uebung.saetze) {
                    textFields.append(CustomTextField(satzIndex: satzIndex, uebung: uebung))
                }
            }
        }
        Button(action: {
            saveWorkout()
        })  {
            Text("Speichern")
        }
    }

    func saveWorkout() {
        let newTrainingseintrag = Trainingseintrag(context: moc)
        newTrainingseintrag.id = UUID()
        newTrainingseintrag.datum = Date()
        
        for textField in textFields {
            let newSatz = Satz(context: moc)
            newSatz.gewicht = Int64(textField.gewicht) ?? 0
            newSatz.wiederholungen = Int64(textField.wiederholungen) ?? 0
            newSatz.uebung = textField.uebung
        }
        do {
            try moc.save()
        } catch {
            print("Error saving workout: \(error)")
        }
    }
}


struct CustomTextField: View {
    @State public var gewicht: String = ""
    @State public var wiederholungen: String = ""
    let satzIndex: Int
    let uebung: Uebung
    
    var body: some View {
        HStack {
            TextField("Gewicht", text: $gewicht)
            TextField("Wiederholungen", text: $wiederholungen)
        }
    }
}




