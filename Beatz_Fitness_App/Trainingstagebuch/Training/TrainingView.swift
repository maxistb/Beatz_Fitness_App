//
//  TrainingstagebuchÜbungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI

struct TrainingView: View {
    @ObservedObject var viewModel: TrainingViewModel
    @State private var showingAlert = false
    
    var body: some View {
        Form {
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
                    }
                    .onDelete { indexSet in
                          guard let firstIndex = indexSet.first else { return }
                          uebung.saetze -= 1
                          viewModel.gewichte[uebungIndex].remove(at: firstIndex)
                          viewModel.wiederholungen[uebungIndex].remove(at: firstIndex)
                      }
                    
                    Button(action: {
                        uebung.saetze += 1
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Hinzufügen")
                        }
                    }
                }
            }
        }
            
            Button(action: {
                viewModel.saveTraining()
                showingAlert = true
            }) {
                Text("Training abschließen")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Training abgeschlossen"), message: Text("Das Training wurde erfolgreich gespeichert."), dismissButton: .default(Text("OK")))
            }
            
            .navigationBarTitle(viewModel.selectedSplit.name ?? "")
        }
    }




