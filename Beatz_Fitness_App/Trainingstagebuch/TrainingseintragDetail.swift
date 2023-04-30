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
        List(trainingseinträge, id: \.self) { trainingseintrag in
            VStack(alignment: .leading) {
                Text(dateFormatter.string(from: trainingseintrag.datum!))
                    .font(.headline)
                ForEach(trainingseintrag.ausgefuehrteSätzeArray, id: \.self) { ausgefuehrterSatz in
                    Text(String(format: "Gewicht: %.2f kg, Wiederholungen: %d", ausgefuehrterSatz.gewicht, ausgefuehrterSatz.wiederholungen))
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
