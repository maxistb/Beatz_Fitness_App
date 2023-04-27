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

    var body: some View {
        VStack {
            Text(dateFormatter.string(from: trainingseintrag.datum!))
                .font(.headline)

            Text("Split Name")
                .font(.subheadline)

            List(trainingseinträge, id: \.self) { trainingseintrag in
                VStack(alignment: .leading) {
                    Text(String(format: "Gewicht: %.2f kg, Wiederholungen: %d", trainingseintrag.gewicht, trainingseintrag.wiederholungen))
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
