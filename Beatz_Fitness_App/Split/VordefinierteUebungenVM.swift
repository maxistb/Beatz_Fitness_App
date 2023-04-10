//
//  UebungListBeatz.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 08.04.23.
//

import SwiftUI

struct VordefinierteUebungen: View {
    @State var uebungen = [
        UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
        UebungsItem(uebungName: "Squat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat"))
    ]
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var anzahlSaetze: [Int] = [1, 1]
    @State private var selectedUebungen: [UebungsItem] = []
    @ObservedObject var split: Split
    @State private var selectedIndices: [Int] = []

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Beine")) {
                    ForEach(uebungen.indices, id: \.self) { index in
                        VStack {
                            HStack {
                                uebungen[index].bild
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                
                                VStack(alignment: .trailing) {
                                    
                                    Text(uebungen[index].uebungName)
                                        .frame(width: 250)
                                        .font(.title3)
                                    
                                    Text(uebungen[index].uebungBeschreibung)
                                        .frame(width: 250)
                                        .foregroundColor(.secondary)
                                    
                                    Stepper("Sätze: \(anzahlSaetze[index])", value: $anzahlSaetze[index], in: 1...10) // Stepper
                                    Button("Add") {
                                        selectedUebungen.append(uebungen[index])
                                    }
                                }
                            }
                                .padding(.vertical)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Übungen")
            .navigationBarItems(trailing: Button(action: {
                print(selectedUebungen)
                addSelectedUebungen()
            }, label: {
                Text("Add")
            }))
        }
    }
    
    func addSelectedUebungen() {
        for uebung in selectedUebungen {
            let neueUebung = Uebung(context: moc)
            neueUebung.id = UUID()
            neueUebung.name = uebung.uebungName
            neueUebung.saetze = Int64(anzahlSaetze[uebungen.firstIndex(where: { $0.id == uebung.id })!])
            split.addToUebung(neueUebung)
        }
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

