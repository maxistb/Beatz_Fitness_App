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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            List {
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
                            .swipeActions {
                                Button(action: {
                                    uebung.saetze -= 1
                                    viewModel.gewichte[uebungIndex].remove(at: saetzeIndex)
                                    viewModel.wiederholungen[uebungIndex].remove(at: saetzeIndex)
                                }, label: {
                                    Image(systemName: "trash")
                                })
                                .tint(.red)
                            }
                        }
                        
                        Button(action: {
                            uebung.saetze += 1
                        }) {
                            Text("Hinzufügen")
                        }
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.saveTraining()
                            showingAlert = true
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
                .listRowBackground(Color.clear)
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(viewModel.selectedSplit.name ?? "")
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Training abgeschlossen"),
                message: Text("Das Training wurde erfolgreich gespeichert."),
                dismissButton: .default(
                    Text("OK"),
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            )
        }
    }
}


