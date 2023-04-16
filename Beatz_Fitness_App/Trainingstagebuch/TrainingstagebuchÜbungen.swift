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
    
    var body: some View {
        List {
            ForEach(selectedSplit.getUebungen) { uebung in
                Section(header: Text(uebung.name ?? "")) {
                    ForEach(0..<textFields.count, id: \.self) { saetzeIndex in
                        textFields[saetzeIndex] // display the custom textfield for each set
                    }
                    Button(action: {
                        textFields.append(CustomTextField()) // add a new custom textfield when the user taps this button
                    }, label: {
                        Label("Add Set", systemImage: "plus")
                    })
                }
            }
        }
        .navigationTitle("Trainingstagebuch")
        .onAppear {
            // initialize the textFields array with the correct number of CustomTextField views
            for uebung in selectedSplit.getUebungen {
                for _ in 0..<Int(uebung.saetze) {
                    textFields.append(CustomTextField())
                }
            }
        }
    }
    
    private func saveTraining() {
        selectedSplit.addToTrainingseintraege(Trainingseintrag(context: moc))
        do {
            try moc.save()
        } catch {
            print("Error saving training: \(error.localizedDescription)")
        }
    }
}

struct CustomTextField: View {
    @State private var gewicht: String = ""
    @State private var wiederholungen: String = ""
    
    var body: some View {
        HStack {
            TextField("Gewicht", text: $gewicht)
            TextField("Wiederholungen", text: $wiederholungen)
        }
    }
}




