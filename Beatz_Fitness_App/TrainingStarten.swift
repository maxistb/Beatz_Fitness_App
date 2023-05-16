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

    var body: some View {
        NavigationView {
            List {
                ForEach(splits, id: \.self) { split in
                    Button(action: {
                        selectedSplit = split
                    }) {
                        HStack {
                            Text(split.name ?? "")
                            Spacer()
                            if split == selectedSplit {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Splits")
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if let split = selectedSplit {
                            NavigationLink(destination: TrainingView(viewModel: TrainingViewModel(selectedSplit: split, moc: moc))) {
                                Label("Training starten", systemImage: "play.circle")
                            }
                        }

                        Spacer()
                    }
                    Spacer()
                }
            )
        }
    }
}