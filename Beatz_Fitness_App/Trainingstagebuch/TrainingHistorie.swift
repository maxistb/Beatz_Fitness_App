//
//  TrainingHistorie.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.04.23.
//

import SwiftUI
import CoreData

struct TrainingHistorie: View {
    @FetchRequest(entity: Trainingseintrag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.datum, ascending: false)])
    var trainingseintraege: FetchedResults<Trainingseintrag>

    var body: some View {
        NavigationView {
            List {
                ForEach(trainingseintraege, id: \.id) { trainingseintrag in
                    NavigationLink(destination: TrainingseintragDetail(trainingseintrag: trainingseintrag)) {
                        VStack(alignment: .leading) {
                            Text(dateFormatter.string(from: trainingseintrag.datum!))
                                .font(.headline)
                            Text(trainingseintrag.split?.name ?? "Unbekannter Übungsname")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarTitle("Trainingseinträge")
        }
    }

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}





