//
//  VordefinierteSplitsView.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.05.23.
//

import SwiftUI

struct VordefinierteSplitView: View {
    let split: VordefinierteSplits
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            List {
                Section(header: Text("Übungen")) {
                    ForEach(split.uebungen) { uebung in
                        VStack {
                            HStack {
                                uebung.bild
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: 100, height: 100)
                                
                                VStack(alignment: .leading) {
                                    Text(uebung.uebungName)
                                        .font(.headline)
                                    
                                    Text(uebung.uebungBeschreibung)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text("Sätze: \(uebung.anzahlSaetze)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle(split.name)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    let neuerSplit = Split(context: moc)
                    neuerSplit.name = split.name
                    
                    for uebung in split.uebungen {
                        let neueUebung = Uebung(context: moc)
                        neueUebung.id = UUID()
                        neueUebung.name = uebung.uebungName
                        neueUebung.saetze = Int64(uebung.anzahlSaetze)
                        neueUebung.notizen = ""
                        
                        neuerSplit.addToUebung(neueUebung)
                    }
                    
                    try? moc.save()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Split Hinzufügen")
                }
            }
        }
    }
}


