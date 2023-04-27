//
//  TrainingHistorie.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.04.23.
//

import SwiftUI
import CoreData

struct TrainingHistorie: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Trainingseintrag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Trainingseintrag.datum, ascending: false)]) var trainingseinträge: FetchedResults<Trainingseintrag>

    var body: some View {
        NavigationView {
            List(trainingseinträge, id: \.self) { trainingseintrag in
                VStack(alignment: .leading) {
                    Text("\(trainingseintrag.datum!, formatter: dateFormatter)")
                    Text("Gewicht: \(trainingseintrag.gewicht) kg, Wiederholungen: \(trainingseintrag.wiederholungen)")
                }
            }
            .navigationBarTitle("Trainingseinträge")
        }
    }

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

