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
    @State public var anzahlSaetze: [Int] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    @State public var selectedUebungen: [UebungsItem] = []
    @ObservedObject var split: Split
    @State public var selectedIndicesBeine: [Int] = []
    @State public var selectedIndicesRücken: [Int] = []
    @State public var selectedIndicesBrust: [Int] = []
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Beine")) {
                    ForEach(uebungenBeine.indices, id: \.self) { index in
                        VStack {
                            HStack {
                                uebungenBeine[index].bild
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: horizontalSizeClass == .compact ? 100 : 130, height: horizontalSizeClass == .compact ? 100 : 130)
                                
                                VStack(alignment: .leading) {
                                    Text(uebungenBeine[index].uebungName)
                                        .font(.headline)
                                    
                                    Text(uebungenBeine[index].uebungBeschreibung)
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
                                        self.selectedIndicesBeine.contains(index)
                                    },
                                    set: {
                                        if $0 {
                                            self.selectedIndicesBeine.append(index)
                                            self.selectedUebungen.append(uebungenBeine[index])
                                        } else {
                                            if let selectedIndex = self.selectedIndicesBeine.firstIndex(of: index) {
                                                self.selectedIndicesBeine.remove(at: selectedIndex)
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
                Section(header: Text("Rücken")) {
                    ForEach(uebungenRücken.indices, id: \.self) { index1 in
                        VStack {
                            HStack {
                                uebungenRücken[index1].bild
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: horizontalSizeClass == .compact ? 100 : 130, height: horizontalSizeClass == .compact ? 100 : 130)
                                
                                VStack(alignment: .leading) {
                                    Text(uebungenRücken[index1].uebungName)
                                        .font(.headline)
                                    
                                    Text(uebungenRücken[index1].uebungBeschreibung)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Stepper("Sätze: \(anzahlSaetze[index1])", value: $anzahlSaetze[index1], in: 1...10)
                                }
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            HStack {
                                Toggle("Zur Übung hinzufügen", isOn: Binding(
                                    get: {
                                        self.selectedIndicesRücken.contains(index1)
                                    },
                                    set: {
                                        if $0 {
                                            self.selectedIndicesRücken.append(index1)
                                            self.selectedUebungen.append(uebungenRücken[index1])
                                        } else {
                                            if let selectedIndex = self.selectedIndicesRücken.firstIndex(of: index1) {
                                                self.selectedIndicesRücken.remove(at: selectedIndex)
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
                Section(header: Text("Brust")) {
                    ForEach(uebungenBrust.indices, id: \.self) { index2 in
                        VStack {
                            HStack {
                                uebungenBrust[index2].bild
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: horizontalSizeClass == .compact ? 100 : 130, height: horizontalSizeClass == .compact ? 100 : 130)
                                
                                VStack(alignment: .leading) {
                                    Text(uebungenBrust[index2].uebungName)
                                        .font(.headline)
                                    
                                    Text(uebungenBrust[index2].uebungBeschreibung)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Stepper("Sätze: \(anzahlSaetze[index2])", value: $anzahlSaetze[index2], in: 1...10)
                                }
                                
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            HStack {
                                Toggle("Zur Übung hinzufügen", isOn: Binding(
                                    get: {
                                        self.selectedIndicesBrust.contains(index2)
                                    },
                                    set: {
                                        if $0 {
                                            self.selectedIndicesBrust.append(index2)
                                            self.selectedUebungen.append(uebungenBrust[index2])
                                        } else {
                                            if let selectedIndex = self.selectedIndicesBrust.firstIndex(of: index2) {
                                                self.selectedIndicesBrust.remove(at: selectedIndex)
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


