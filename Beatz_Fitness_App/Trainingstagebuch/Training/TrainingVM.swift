//
//  TrainingVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI
import CoreData

class TrainingViewModel: ObservableObject {
    @Published var gewichte: [[String]] = []
    @Published var wiederholungen: [[String]] = []
    @Published var isAufwärmsatz: [[Bool]] = []
    @Published var isDropsatz: [[Bool]] = []
    @Published var notizenTraining: String = ""
    let selectedSplit: Split
    let moc: NSManagedObjectContext
    var selectedUebung: Uebung?
    
    init(selectedSplit: Split, moc: NSManagedObjectContext) {
        self.selectedSplit = selectedSplit
        self.moc = moc
        initializeArrays()
    }
    
    func getPreviousTrainingWeights() -> [[String]] {
        guard let splitName = selectedSplit.name else {
            return []
        }
        
        let fetchRequest: NSFetchRequest<Trainingseintrag> = Trainingseintrag.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "split.name == %@", splitName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "datum", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try moc.fetch(fetchRequest)
            if let lastTrainingEntry = results.first {
                let ausgefuehrteSätzeArray = lastTrainingEntry.ausgefuehrteSätzeArray
                let uebungenCount = selectedSplit.getUebungen.count
                let maxSatzOrder = ausgefuehrteSätzeArray.map { $0.satzIndex }.max() ?? 0
                var previousWeights: [[String]] = Array(repeating: Array(repeating: "", count: Int(maxSatzOrder) + 1), count: uebungenCount)
                
                for satz in ausgefuehrteSätzeArray {
                    if let uebungIndex = selectedSplit.getUebungen.firstIndex(where: { $0.name == satz.uebungname }) {
                        previousWeights[uebungIndex][Int(satz.satzIndex)] = String(satz.gewicht)
                    }
                }
                
                print(previousWeights)
                return previousWeights
            }
        } catch {
            print("Error fetching previous training entry: \(error.localizedDescription)")
        }
        
        return []
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
        let uebungenCount = selectedSplit.getUebungen.count
        for index in 0..<uebungenCount {
            let uebung = selectedSplit.getUebungen[index]
            let satzCount = Int(uebung.saetze)
            
            gewichte.append(Array(repeating: "", count: satzCount))
            wiederholungen.append(Array(repeating: "", count: satzCount))
            isAufwärmsatz.append(Array(repeating: false, count: satzCount))
            isDropsatz.append(Array(repeating: false, count: satzCount))
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
                        .background(Color(red: 0/255, green: 166/255, blue: 205/255))
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
