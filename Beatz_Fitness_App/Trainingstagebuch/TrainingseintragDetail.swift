//
//  TrainingseintragDetail.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 27.04.23.
//

import SwiftUI
import CoreData

struct TrainingseintragDetail: View {
    var trainingseintrag: Trainingseintrag
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Trainingseintrag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.datum, ascending: false)]) var trainingseinträge: FetchedResults<Trainingseintrag>

    var ausgefuehrteSätzeNachUebung: [String: [AusgefuehrterSatz]] {
        Dictionary(grouping: trainingseintrag.ausgefuehrteSätzeArray) { $0.uebungname ?? "Fehler" }
    }

    var body: some View {
        List {
            ForEach(Array(ausgefuehrteSätzeNachUebung.keys.sorted()), id: \.self) { uebungname in
                Section(header: Text(uebungname)) {
                    ForEach(ausgefuehrteSätzeNachUebung[uebungname]!, id: \.self) { ausgefuehrterSatz in
                        Text(String(format: "Gewicht: %.2f kg, Wiederholungen: %d", ausgefuehrterSatz.gewicht, ausgefuehrterSatz.wiederholungen))
                    }
                }
            }
        }
        .navigationBarTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(alignment: .center) {
                        Text(trainingseintrag.split?.name ?? "")
                            .font(.headline)
                        Text(dateFormatter.string(from: trainingseintrag.datum!))
                            .font(.subheadline)
                    }
                }
            }
    }
        


 
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}

