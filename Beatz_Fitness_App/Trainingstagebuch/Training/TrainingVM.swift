//
//  TrainingVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI
import CoreData

class TrainingViewModel: ObservableObject {
    @Published var gewichte: [[String]] = Array(repeating: Array(repeating: "", count: 20), count: 20)
    @Published var wiederholungen: [[String]] = Array(repeating: Array(repeating: "", count: 20), count: 20)
    let selectedSplit: Split
    let moc: NSManagedObjectContext
    var selectedUebung: Uebung?
    @Published var isAufwärmsatz: [[Bool]] = Array(repeating: Array(repeating: false, count: 20), count: 20)
    @Published var isDropsatz: [[Bool]] = Array(repeating: Array(repeating: false, count: 20), count: 20)
    @Published var notizenTraining: String = ""
    
    init(selectedSplit: Split, moc: NSManagedObjectContext) {
        self.selectedSplit = selectedSplit
        self.moc = moc
        initializeArrays()
    }
    
    func gewichtTextField(value: Binding<String>) -> some View {
           TextField("Gewicht", text: value)
               .keyboardType(.decimalPad)
               .overlay(
                   Text("kg"),
                   alignment: .trailing
               )
       }
    
    private func initializeArrays() {
           for index in selectedSplit.getUebungen.indices {
               let uebung = selectedSplit.getUebungen[index]
               isAufwärmsatz[index] = Array(repeating: false, count: Int(uebung.saetze))
               isDropsatz[index] = Array(repeating: false, count: Int(uebung.saetze))
           }
       }
    
    func wiederholungenTextField(value: Binding<String>) -> some View {
        TextField("Wdh.", text: value)
            .keyboardType(.decimalPad)
            .overlay(
                Text("Wdh."),
                alignment: .trailing
            )
    }
    
    func createButton(showingAlert: Binding<Bool>) -> some View {
           Section {
               HStack {
                   Spacer()
                   Button(action: {
                       self.saveTraining()
                       showingAlert.wrappedValue = true
                   }) {
                       Text("Training abschließen")
                           .font(.headline)
                           .foregroundColor(.white)
                           .frame(height: 50)
                           .frame(width: 200)
                           .background(Color.blue)
                           .cornerRadius(15.0)
                   }
                   .padding(.vertical)
                   Spacer()
               }
           }
       }
    
    func saveTraining() {
        guard gewichte.count == wiederholungen.count else {
            return
        }

        let trainingseintrag = Trainingseintrag(context: moc)
        trainingseintrag.datum = Date()
        trainingseintrag.id = UUID()
        trainingseintrag.split = selectedSplit
        trainingseintrag.notizen = notizenTraining
        
        var currentIndex = 0

        for (index, uebung) in selectedSplit.getUebungen.enumerated() {
            let uebungsname = uebung.name ?? ""

            for satzIndex in 0..<Int(uebung.saetze) {
                let ausgefuehrterSatz = AusgefuehrterSatz(context: moc)
                ausgefuehrterSatz.gewicht = Double(gewichte[index][satzIndex]) ?? 0.0
                ausgefuehrterSatz.wiederholungen = Int64(wiederholungen[index][satzIndex]) ?? 0
                ausgefuehrterSatz.id = UUID()
                ausgefuehrterSatz.uebungname = uebungsname

                ausgefuehrterSatz.isDropsatz = isDropsatz[index][satzIndex]
                ausgefuehrterSatz.isAufwaermsatz = isAufwärmsatz[index][satzIndex]
                
                ausgefuehrterSatz.satzIndex = Int64(currentIndex)

                trainingseintrag.addToAusgefuehrteUebungen(ausgefuehrterSatz)
                currentIndex += 1
            }
        }
        do {
            try moc.save()
        } catch {
            print("Error saving trainingseinheit: \(error.localizedDescription)")
        }
    }
    
}
