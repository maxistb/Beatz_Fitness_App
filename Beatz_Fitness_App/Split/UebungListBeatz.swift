//
//  UebungListBeatz.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 08.04.23.
//

import SwiftUI

struct UebungListBeatz: View {
    @State var uebungen = [
        UebungListeBeatz(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
        UebungListeBeatz(uebungName: "Squat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat"))
    ]
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var anzahlSaetze: [Int] = [1, 1]
    @State private var selectedUebungen: [UebungListeBeatz] = []
    var split: Split
    
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
                                }
                            }
                            Checkbox(isChecked: $uebungen[index].isChecked)
                                .padding(.vertical)
                                .padding(.horizontal)
                                .onTapGesture {
                                    uebungen[index].isChecked.toggle()
                                    if uebungen[index].isChecked {
                                        selectedUebungen.append(uebungen[index])
                                    } else {
                                        selectedUebungen.removeAll(where: { $0.id == uebungen[index].id })
                                    }
                                    
                                }
                                .onLongPressGesture {
                                    uebungen[index].isChecked.toggle()
                                    if uebungen[index].isChecked {
                                        selectedUebungen.append(uebungen[index])
                                    } else {
                                        selectedUebungen.removeAll(where: { $0.id == uebungen[index].id })
                                    }
                                    
                                }
                        }
                    }
                }
            }
            .navigationTitle("Übungen")
            .navigationBarItems(trailing: Button(action: {
                addSelectedUebungen()
            }, label: {
                Text("Add")
            }))
        }
    }
    
    private func addSelectedUebungen() {
        for (index, uebung) in selectedUebungen.enumerated() {
            let neueUebung = Uebung(context: moc)
            neueUebung.id = UUID()
            neueUebung.name = uebung.uebungName
            neueUebung.saetze = Int64(anzahlSaetze[index])
            split.addToUebung(neueUebung)
        }
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}


struct Checkbox: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .foregroundColor(.accentColor)
            .onTapGesture {
                isChecked.toggle()
            }
    }
}

struct UebungListeBeatz: Identifiable {
    var id = UUID()
    let uebungName: String
    let uebungBeschreibung: String
    var anzahlSaetze: Int
    let bild: Image
    var isChecked: Bool = false
}
