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
                ForEach(Array(trainingseintraege)) { trainingseintrag in
                    Section(header: Text(dateFormatter.string(from: trainingseintrag.datum!))) {
//                        let satzArray = trainingseintrag
//                        ForEach(satzArray, id: \.self) { satz in
//                            HStack {
//                                Text(satz.uebung?.name ?? "")
//                                Spacer()
//                                Text("\(satz.gewicht) kg x \(satz.wiederholungen) Wiederholungen")
//                            }
//                        }
                    }

                }
            }
            .navigationTitle("Trainingshistorie")
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
