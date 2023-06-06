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
//        print(gewichteArray)
//        print(wiederholungenArray)
        return (gewichteArray, wiederholungenArray)
   
    }
    
    func getNextSatzIndex() -> Int64 {
        let currentIndex = ausgefuehrteSätzeNachUebung.flatMap { $0.value }.map { $0.satzIndex }.max() ?? -1
        return max(currentIndex + 1, 0)
    }


    func delete(ausgefuehrterSatz: AusgefuehrterSatz) {
        let satzIndex = ausgefuehrterSatz.satzIndex
        trainingseintrag.removeFromAusgefuehrteUebungen(ausgefuehrterSatz)
        try? moc.save()
        
        for ausgefuehrterSatz in trainingseintrag.ausgefuehrteSätzeArray {
            if ausgefuehrterSatz.satzIndex > satzIndex {
                ausgefuehrterSatz.satzIndex -= 1
            }
//            print(satzIndex)
        }
        
        try? moc.save()
    }

    func move(from source: IndexSet, to destination: Int) {
        let sortedSätze = trainingseintrag.ausgefuehrteSätzeArray.sorted { $0.satzIndex < $1.satzIndex }
        
        var newSätze = Array(sortedSätze)
        newSätze.move(fromOffsets: source, toOffset: destination)
        
        for (index, satz) in newSätze.enumerated() {
            satz.satzIndex = Int64(index)
//            print("\(satz.satzIndex)")
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
