//
//  TrainingseintragDetailVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 13.05.23.
//

import SwiftUI

extension TrainingseintragDetailView {

    func delete(ausgefuehrterSatz: AusgefuehrterSatz) {
        trainingseintrag.removeFromAusgefuehrteUebungen(ausgefuehrterSatz)
        try? moc.save()
    }
    
    func move(from source: IndexSet, to destination: Int) {
         var indices = Array(source)
         indices.sort()
         for (i, index) in indices.enumerated() {
             if index < destination {
                 trainingseinträge[destination - indices.count + i].split.order = Int64(index)
             } else {
                 trainingseinträge[destination + i].split.order = Int64(index + indices.count)
             }
         }
         try? moc.save()
     }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    let locale = Locale(identifier: "de_DE")
    formatter.locale = locale
    return formatter
}()
