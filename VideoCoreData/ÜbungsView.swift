//
//  ÜbungsView.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI

struct ÜbungsView: View {
    @State private var übungsName = ""
    @StateObject var übungsVM: ÜbungsViewModel
    let split: Split

    init(split: Split) {
        self.split = split
        self._übungsVM = StateObject(wrappedValue: ÜbungsViewModel(split: split))
    }

    var body: some View {
        VStack {
            List {
                ForEach(übungsVM.uebungen) { übung in
                    Text(übung.name ?? "Error")
                }
            }
            .navigationTitle("Übungen für \(split.name ?? "Error")")

            HStack {
                TextField("Neue Übung", text: $übungsName)
                Button("Hinzufügen") {
                    übungsVM.addData(name: übungsName)
                    übungsName = ""
                }
            }
            .padding()
        }
    }
}

