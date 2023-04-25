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
        UebungsItem(uebungName: "Squat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("TestBild")),
        UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
        UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("BeatzLogo")),
        UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
        UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
        UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat"))
    ]
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var anzahlSaetze: [Int] = [1, 1, 1, 1, 1, 1, 1]
    @State private var selectedUebungen: [UebungsItem] = []
    @ObservedObject var split: Split
    @State private var selectedIndices: [Int] = []
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
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
                                    .frame(width: horizontalSizeClass == .compact ? 100 : 130, height: horizontalSizeClass == .compact ? 100 : 130)
                                
                                VStack(alignment: .leading) {
                                    Text(uebungen[index].uebungName)
                                        .font(.headline)
                                    
                                    Text(uebungen[index].uebungBeschreibung)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Stepper("Sätze: \(anzahlSaetze[index])", value: $anzahlSaetze[index], in: 1...10)
                                }
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            HStack {
                                Toggle("Zur Übung hinzufügen", isOn: Binding(
                                    get: {
                                        self.selectedIndices.contains(index)
                                    },
                                    set: {
                                        if $0 {
                                            self.selectedIndices.append(index)
                                            self.selectedUebungen.append(uebungen[index])
                                        } else {
                                            if let selectedIndex = self.selectedIndices.firstIndex(of: index) {
                                                self.selectedIndices.remove(at: selectedIndex)
                                                self.selectedUebungen.remove(at: selectedIndex)
                                            }
                                        }
                                    }
                                ))
                            }
                            .toggleStyle(iOSCheckboxToggleStyle())
                        }
                    }
                }
            }
            .navigationTitle("Übungen")
            .navigationBarItems(trailing: Button(action: {
                addSelectedUebungen()
            }, label: {
                Text("Hinzufügen")
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

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}
