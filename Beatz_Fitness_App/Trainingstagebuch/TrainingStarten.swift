//
//  Trainingstagebuch.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 09.04.23.
//

import SwiftUI

struct Trainingstagebuch: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Split.entity(), sortDescriptors: [])
    var splits: FetchedResults<Split>
    @State private var selectedSplit: Split?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                if splits.isEmpty {
                        Text("Füge Splits hinzu! 🏋🏻")
                            .font(.headline)
                            .foregroundColor(.primary)
                }
                    
                    else {
                        VStack {
                            ForEach(splits, id: \.self) { split in
                                Button(action: {
                                    selectedSplit = split
                                }) {
                                    HStack {
                                        Text(split.name ?? "")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if split == selectedSplit {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color(red: 0/255, green: 166/255, blue: 205/255))
                                        }
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(colorScheme == .dark ? Color(red: 28/255, green: 27/255, blue: 31/255) : Color.white)
                                    )
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 2)
                            }
                        }
                        .padding(.top)
                    }
                Section {
                    HStack {
                        Spacer()
                        if let split = selectedSplit {
                            NavigationLink(destination: TrainingView(viewModel: TrainingViewModel(selectedSplit: split, moc: moc))) {
                                Text("Training starten")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 200)
                                    .frame(height: 50)
                                    .background(Color(red: 0/255, green: 166/255, blue: 205/255))
                                    .cornerRadius(15.0)
                            }
                            .padding(.top)
                        }
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("🏅 Splits")
        }
        .accentColor(Color(red: 0/255, green: 166/255, blue: 205/255))
    }
}
