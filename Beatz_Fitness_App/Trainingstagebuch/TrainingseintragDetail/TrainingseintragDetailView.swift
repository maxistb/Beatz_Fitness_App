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
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Trainingseintrag.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.datum, ascending: true)])
    var trainingseinträge: FetchedResults<Trainingseintrag>
    var ausgefuehrteSätzeNachUebung: [String: [AusgefuehrterSatz]] {
        Dictionary(grouping: trainingseintrag.ausgefuehrteSätzeArray.sorted(by: { $0.satzIndex < $1.satzIndex })) { $0.uebungname ?? "Fehler" }
    }
    @State private var gewichte: [Double] = []
    @State private var wiederholungen: [Int] = []
    
    init(trainingseintrag: Trainingseintrag) {
           self.trainingseintrag = trainingseintrag
           _gewichte = State(initialValue: saveGewichteUndWiederholungen().0)
           _wiederholungen = State(initialValue: saveGewichteUndWiederholungen().1)
       }
    
    var body: some View {
        List {
            ForEach(Array(ausgefuehrteSätzeNachUebung.keys.sorted()), id: \.self) { uebungname in
                Section(header: Text(uebungname)) {
                    ForEach(ausgefuehrteSätzeNachUebung[uebungname]!, id: \.self) { ausgefuehrterSatz in
                        HStack {
                            if let ausgefuehrterSatz = ausgefuehrteSätzeNachUebung[uebungname]?.first(where: { $0.id == ausgefuehrterSatz.id }) {
                                if ausgefuehrterSatz.isDropsatz {
                                    Section(header: Text("Dropsatz")) {
                                        createGewichtTextField(for: ausgefuehrterSatz)
                                    }
                                } else if ausgefuehrterSatz.isAufwaermsatz {
                                    Section(header: Text("Aufwärm.")) {
                                        createGewichtTextField(for: ausgefuehrterSatz)
                                    }
                                } else {
                                    createGewichtTextField(for: ausgefuehrterSatz)
                                }
                                createWiederholungenTextField(for: ausgefuehrterSatz)
                                Spacer()
                            }
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
                    Button(action: {
                        withAnimation {
                            let neuerSatz = AusgefuehrterSatz(context: moc)
                            neuerSatz.uebungname = uebungname
                            neuerSatz.datum = Date()
                            neuerSatz.id = UUID()
                            neuerSatz.satzIndex = getNextSatzIndex()

                            print("\(neuerSatz.uebungname): \(neuerSatz.satzIndex)")
                            trainingseintrag.addToAusgefuehrteUebungen(neuerSatz)
                            try? moc.save()
                        }
                    }) {
                        Text("Hinzufügen")
                            .foregroundColor(Color(red: 0/255, green: 166/255, blue: 205/255))
                    }
                }
            }
            Section(header: Text("Notizen")) {
                Text(trainingseintrag.notizen)
            }
        }
        .navigationTitle(trainingseintrag.split.name ?? "")
    }
}
