//
//  TrainingseintragDetail.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 27.04.23.
//

import SwiftUI
import CoreData

struct TrainingseintragDetailView: View {
    var trainingseintrag: Trainingseintrag
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Trainingseintrag.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.datum, ascending: true)])
    var trainingseinträge: FetchedResults<Trainingseintrag>
    var ausgefuehrteSätzeNachUebung: [String: [AusgefuehrterSatz]] {
        Dictionary(grouping: trainingseintrag.ausgefuehrteSätzeArray.sorted(by: { $0.datum ?? Date() > $1.datum ?? Date() })) { $0.uebungname ?? "Fehler" }
    }

    var body: some View {
        List {
            ForEach(Array(ausgefuehrteSätzeNachUebung.keys.sorted()), id: \.self) { uebungname in
                Section(header: Text(uebungname)) {
                    ForEach(ausgefuehrteSätzeNachUebung[uebungname]!, id: \.self) { ausgefuehrterSatz in
                                    HStack {
                                        TextField("Gewicht", text: Binding(
                                            get: {
                                                if ausgefuehrterSatz.gewicht == 0.0 {
                                                    return ""
                                                } else {
                                                    let weightString = String(format: "%.2f", ausgefuehrterSatz.gewicht)
                                                    if weightString.hasSuffix(".00") {
                                                        return String(Int(ausgefuehrterSatz.gewicht))
                                                    } else {
                                                        return weightString.replacingOccurrences(of: ",", with: ".")
                                                    }
                                                }
                                            },
                                            set: { newValue in
                                                let filteredValue = newValue.replacingOccurrences(of: ",", with: ".")
                                                if let value = Double(filteredValue) {
                                                    ausgefuehrterSatz.gewicht = value
                                                } else {
                                                    ausgefuehrterSatz.gewicht = 0.0
                                                }
                                                try? moc.save()
                                            }
                                        ))
                                        .keyboardType(.decimalPad)



                                        TextField("Wiederholungen", text: Binding(
                                            get: {
                                                if ausgefuehrterSatz.wiederholungen == 0 {
                                                    return ""
                                                } else {
                                                    return String(ausgefuehrterSatz.wiederholungen)
                                                }
                                            },
                                            set: { newValue in
                                                if let value = Double(newValue) {
                                                    ausgefuehrterSatz.wiederholungen = Int64(value)
                                                } else {
                                                    ausgefuehrterSatz.wiederholungen = 0
                                                }
                                                try? moc.save()
                                            }
                                        ))
                                        .keyboardType(.numberPad)

                            Spacer()
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                delete(ausgefuehrterSatz: ausgefuehrterSatz)
                                saveGewichteUndWiederholungen()
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                    }
                    .onMove(perform: move)

                    
                    Button("Hinzufügen") {
                        let newSatz = AusgefuehrterSatz(context: moc)
                        newSatz.gewicht = 0.0
                        newSatz.wiederholungen = 0
                        newSatz.uebungname = uebungname
                        newSatz.datum = Date()
                        trainingseintrag.addToAusgefuehrteUebungen(newSatz)
                        try? moc.save()
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(alignment: .center) {
                    Text(trainingseintrag.split.name ?? "")
                        .font(.headline)
                    Text(dateFormatter.string(from: trainingseintrag.datum!))
                        .font(.subheadline)
                }
            }
        }
    }
}
