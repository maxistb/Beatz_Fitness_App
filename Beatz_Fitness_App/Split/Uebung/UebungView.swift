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
    @State private var settingsDetent = PresentationDetent.medium
    
    var body: some View {
        VStack {
            List {
                ForEach(split.getUebungen) { uebung in
                    HStack {
                        Text(uebung.name ?? "Error")
                        Text("\(uebung.saetze) Sätze")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            
            .navigationBarTitle(Text(split.name ?? "Error"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button(action: {
                            showAddUebungView = true
                        }) {
                            Label("Eigene Übung", systemImage: "square.and.pencil")
                        }
                        
                        Button(action: {
                            showUebungListBeatz = true
                        }) {
                            Label("Vordefinierte Übungen", systemImage: "dumbbell.fill")
                        }
                        
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddUebungView) {
                NavigationView {
                    AddUebungView(split: split)
                }
                .presentationDetents(
                    [.medium, .large],
                    selection: $settingsDetent
                )
                .navigationTitle("Übung hinzufügen")
            }
            .sheet(isPresented: $showUebungListBeatz) {
                VordefinierteUebungen(split: split)
            }
        }
    }
}
