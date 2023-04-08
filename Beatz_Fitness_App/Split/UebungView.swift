//
//  SplitDetail.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//

import SwiftUI

struct UebungView: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var split: Split
    @State private var name = ""
    @State private var showAddUebungView = false
    @State private var showUebungListBeatz = false
    
    var body: some View {
        VStack {
            List(split.getUebungen) { uebung in
                HStack {
                    Text(uebung.name ?? "Error")
                    Text("\(uebung.saetze) Sätze")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            .navigationBarTitle(Text(split.name ?? "Error"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button(action: {
                            showAddUebungView = true
                        }) {
                            Label("Eigene Übung", systemImage: "pencil")
                        }
                        
                        Button(action: {
                            showUebungListBeatz = true
                        }) {
                            Label("Vordefinierte Übungen", systemImage: "pencil")
                        }
                        
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddUebungView) {
                AddUebungView(split: split)
                    .navigationTitle("Übung hinzufügen")
            }
            .sheet(isPresented: $showUebungListBeatz) {
                UebungListBeatz()
            }
        }
    }
}










