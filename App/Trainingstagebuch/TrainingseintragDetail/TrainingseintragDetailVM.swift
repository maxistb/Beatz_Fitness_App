//
//  TrainingseintragDetailVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 13.05.23.
//

import SwiftUI

extension TrainingseintragDetailView {
    
    func saveGewichteUndWiederholungen() -> ([Double], [Int]) {
        var gewichteArray: [Double] = []
        var wiederholungenArray: [Int] = []
        
        for (_, ausgefuehrteSaetze) in ausgefuehrteSätzeNachUebung {
            for ausgefuehrterSatz in ausgefuehrteSaetze {
                gewichteArray.append(ausgefuehrterSatz.gewicht)
                wiederholungenArray.append(Int(ausgefuehrterSatz.wiederholungen))
            }
        }
        print(gewichteArray)
        print(wiederholungenArray)
        return (gewichteArray, wiederholungenArray)
   
    }
    
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
    
    func createGewichtTextField(for ausgefuehrterSatz: AusgefuehrterSatz) -> some View {
           TextField("Gewicht", text: Binding(
               get: {
                   if ausgefuehrterSatz.gewicht == 0.0 {
                       return ""
                   } else {
                       let weightString = String(format: "%.2f", ausgefuehrterSatz.gewicht)
                       if weightString.hasSuffix(".00") {
                           return String(Int(ausgefuehrterSatz.gewicht))
                       } else {
                           return weightString.replacingOccurrences(of: ",", with: ".")
                       }
                   }
               },
               set: { newValue in
                   let filteredValue = newValue.replacingOccurrences(of: ",", with: ".")
                   if let value = Double(filteredValue) {
                       ausgefuehrterSatz.gewicht = value
                   } else {
                       ausgefuehrterSatz.gewicht = 0.0
                   }
                   try? moc.save()
               }
           ))
           .overlay(
               Text("kg"),
               alignment: .trailing
           )
           .keyboardType(.decimalPad)
       }
    
    func createWiederholungenTextField(for ausgefuehrterSatz: AusgefuehrterSatz) -> some View {
        TextField("Wdh.", text: Binding(
            get: {
                if ausgefuehrterSatz.wiederholungen == 0 {
                    return ""
                } else {
                    return String(ausgefuehrterSatz.wiederholungen)
                }
            },
            set: { newValue in
                if let value = Double(newValue) {
                    ausgefuehrterSatz.wiederholungen = Int64(value)
                } else {
                    ausgefuehrterSatz.wiederholungen = 0
                }
                try? moc.save()
            }
        ))
        .overlay(
            Text("Wdh."),
            alignment: .trailing
        )
        .keyboardType(.numberPad)
    }
    
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    let locale = Locale(identifier: "de_DE")
    formatter.locale = locale
    return formatter
}()
