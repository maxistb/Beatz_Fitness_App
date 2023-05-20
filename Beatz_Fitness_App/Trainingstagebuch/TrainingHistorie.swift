//
//  TrainingHistorie.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.04.23.
//

import SwiftUI
import CoreData

struct TrainingHistorieView: View {
    @FetchRequest(entity: Trainingseintrag.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.datum, ascending: false)]
    )
    var trainingseintraege: FetchedResults<Trainingseintrag>
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(trainingseintraege, id: \.id) { trainingseintrag in
                    NavigationLink(destination: TrainingseintragDetailView(trainingseintrag: trainingseintrag)) {
                        VStack(alignment: .leading) {
                            Text(dateFormatter.string(from: trainingseintrag.datum!))
                                .font(.headline)
                            Text(trainingseintrag.split.name ?? "")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete { indexSet in
                    deleteTrainingseintraege(at: indexSet)
                }
            }
            .navigationBarTitle("Trainingseinträge")
        }
    }
    func deleteTrainingseintraege(at offsets: IndexSet) {
        for index in offsets {
            let trainingseintrag = trainingseintraege[index]
            moc.delete(trainingseintrag)
        }
        try? moc.save()
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}

