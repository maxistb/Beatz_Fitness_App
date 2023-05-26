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
    @State private var gewichte: [Double] = []
    @State private var wiederholungen: [Int] = []
    
    var body: some View {
        List {
            ForEach(Array(ausgefuehrteSätzeNachUebung.keys.sorted()), id: \.self) { uebungname in
                Section(header: Text(uebungname)) {
                    ForEach(ausgefuehrteSätzeNachUebung[uebungname]!, id: \.self) { ausgefuehrterSatz in
                        HStack {
                            if ausgefuehrterSatz.isDropsatz {
                                Section(header: Text("Dropsatz")) {
                                    createGewichtTextField(for: ausgefuehrterSatz)
                                }
                            }
                            else if ausgefuehrterSatz.isDropsatz {
                                Section(header: Text("Aufwärm.")) {
                                    createGewichtTextField(for: ausgefuehrterSatz)
                                }
                            }
                            else {
                                createGewichtTextField(for: ausgefuehrterSatz)
                            }
                            createWiederholungenTextField(for: ausgefuehrterSatz)
                            
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
                }
            }
            Section(header: Text("Notizen")) {
                Text(trainingseintrag.notizen)
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
        .onChange(of: ausgefuehrteSätzeNachUebung) { _ in
            (gewichte, wiederholungen) = saveGewichteUndWiederholungen()
        }
    }
}

