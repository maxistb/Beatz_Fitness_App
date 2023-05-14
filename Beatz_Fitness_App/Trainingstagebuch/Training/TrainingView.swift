//
//  TrainingstagebuchÜbungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI

struct TrainingView: View {
    @ObservedObject var viewModel: TrainingViewModel

    var body: some View {
        VStack {
            ForEach(viewModel.selectedSplit.getUebungen.indices, id: \.self) { uebungIndex in
                let uebung = viewModel.selectedSplit.getUebungen[uebungIndex]
                
                Section(header: Text(uebung.name ?? "")) {
                    ForEach(0..<Int(uebung.saetze), id: \.self) { saetzeIndex in
                        HStack {
                            TextField("Gewicht", text: Binding(
                                get: { viewModel.gewichte[uebungIndex][saetzeIndex] },
                                set: { newValue in
                                    var newValue = newValue
                                    newValue = newValue.replacingOccurrences(of: ",", with: ".")
                                    if let value = Double(newValue), value > 0 {
                                        viewModel.gewichte[uebungIndex][saetzeIndex] = newValue
                                    }
                                }
                            ))
                            .keyboardType(.decimalPad)

                            .keyboardType(.decimalPad)
                            TextField("Wiederholungen", text: Binding(
                                get: { viewModel.wiederholungen[uebungIndex][saetzeIndex] },
                                set: { newValue in
                                    if let value = Int(newValue), value > 0 {
                                        viewModel.wiederholungen[uebungIndex][saetzeIndex] = newValue
                                    }
                                }
                            ))
                            .keyboardType(.numberPad)
                        }
                        .onChange(of: viewModel.selectedUebung) { newValue in
                            if let newValue = newValue {
                                self.viewModel.selectedUebung = newValue
                            }
                        }
                    }
                }
            }
            Button(action: viewModel.saveTraining) {
                Text("Training abschließen")
            }
        }
    }
}
