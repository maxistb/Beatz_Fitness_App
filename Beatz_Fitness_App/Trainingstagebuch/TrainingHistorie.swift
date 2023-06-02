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
            VStack {
                if trainingseintraege.isEmpty {
                    Text("Du hast noch keine Einträge 🫤")
                } else {
                    List {
                        ForEach(trainingseintraege, id: \.id) { trainingseintrag in
                            NavigationLink(destination: TrainingseintragDetailView(trainingseintrag: trainingseintrag)) {
                                VStack(alignment: .leading) {
                                    Text(trainingseintrag.split.name ?? "")
                                        .font(.headline)
                                    Text(dateFormatter.string(from: trainingseintrag.datum ?? Date()))
                                        .font(.subheadline)
                                }
                            }
                            .swipeActions {
                                Button(action: {
                                    deleteTrainingseintraege(at: trainingseintraege.firstIndex(of: trainingseintrag)!)
                                }) {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("📖 Trainingseinträge")
        }
    }
    
    func deleteTrainingseintraege(at index: Int) {
        let trainingseintrag = trainingseintraege[index]
        moc.delete(trainingseintrag)
        
        do {
            try moc.save()
        } catch {
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "de_DE")
        return formatter
    }()

}

