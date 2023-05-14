//
//  UebungListBeatz.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 08.04.23.
//

import SwiftUI

struct VordefinierteUebungen: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State public var anzahlSaetze: [Int] = [1, 1, 1, 1, 1, 1, 1]
    @State public var selectedUebungen: [UebungsItem] = []
    @ObservedObject var split: Split
    @State public var selectedIndices: [Int] = []
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
}


