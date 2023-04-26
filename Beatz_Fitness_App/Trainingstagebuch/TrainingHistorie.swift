//
//  TrainingHistorie.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.04.23.
//

import SwiftUI
import CoreData

struct TrainingHistorie: View {
    @FetchRequest(entity: Trainingseintrag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.datum, ascending: false)]) var trainingseintraege: FetchedResults<Trainingseintrag>

    var body: some View {
        NavigationView {
            List {
                ForEach(trainingseintraege) { trainingseintrag in
                    NavigationLink(destination: TrainingseintragDetailView(trainingseintrag: trainingseintrag)) {
                        TrainingseintragRow(trainingseintrag: trainingseintrag)
                    }
                }
            }
            .navigationTitle("Trainingshistorie")
        }
    }
}

struct TrainingseintragRow: View {
    let trainingseintrag: Trainingseintrag
    
    var body: some View {
        Section(header: Text(dateFormatter.string(from: trainingseintrag.datum!))) {
            ForEach(trainingseintrag.split?.getUebungenArray ?? [], id: \.self) { uebung in
                HStack {
                    Text(uebung.name ?? "")
                    Spacer()
                    if let saetze = trainingseintrag.getSaetzeForUebung(uebung: uebung), !saetze.isEmpty {
                        let satz = saetze[0] // for simplicity, only show the first set
                        Text("\(satz.gewicht) kg x \(satz.wiederholungen) Wiederholungen")
                    } else {
                        Text("-")
                    }
                }
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

struct TrainingseintragDetailView: View {
    let trainingseintrag: Trainingseintrag
    
    var body: some View {
        List {
            ForEach(trainingseintrag.split?.getUebungenArray ?? [], id: \.self) { uebung in
                Section(header: Text(uebung.name ?? "")) {
                    ForEach(trainingseintrag.getSaetzeForUebung(uebung: uebung)) { satz in
                        HStack {
                            Text("\(satz.gewicht) kg x \(satz.wiederholungen) Wiederholungen")
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle(dateFormatter.string(from: trainingseintrag.datum!))
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}



