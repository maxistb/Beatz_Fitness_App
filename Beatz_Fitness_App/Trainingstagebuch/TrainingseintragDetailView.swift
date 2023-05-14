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
        Dictionary(grouping: trainingseintrag.ausgefuehrteSätzeArray) { $0.uebungname ?? "Fehler" }
    }
 
    
    
    var body: some View {
        List {
            ForEach(Array(ausgefuehrteSätzeNachUebung.keys.sorted()), id: \.self) { uebungname in
                Section(header: Text(uebungname)) {
                    ForEach(ausgefuehrteSätzeNachUebung[uebungname]!, id: \.self) { ausgefuehrterSatz in
                        HStack {
                            Text(String(format: "Gewicht: %.2f kg, Wiederholungen: %d", arguments: [ausgefuehrterSatz.gewicht, ausgefuehrterSatz.wiederholungen]))
                            Spacer()
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                delete(ausgefuehrterSatz: ausgefuehrterSatz)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                        }
                    }
                    .onMove(perform: move)

                    Button("Hinzufügen") {
                        alertTF(title: "Split Hinzufügen", message: "Füge hier einen neuen Satz zur aktuellen Übung hinzu.", gewichtText: "Gewicht", wiederholungenText: "Wiederholungen", primaryTitle: "Hinzufügen", secondaryTitle: "Abbrechen") { gewicht, wiederholungen in
                            if isValidInput(input: gewicht) {
                                
                                let newSatz = AusgefuehrterSatz(context: moc)
                                newSatz.gewicht = Double(gewicht) ?? 0.0
                                newSatz.wiederholungen = Int64(wiederholungen) ?? 0
                                newSatz.id = UUID()
                                newSatz.uebungname = uebungname
                                trainingseintrag.addToAusgefuehrteUebungen(newSatz)
                                try? moc.save()

                            } else {
                                print("Ungültige Eingabe")
                            }
                        } secondaryAction: {
                            print("Abbrechen")
                        }
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
