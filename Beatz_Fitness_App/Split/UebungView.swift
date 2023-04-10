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
                NavigationView {
                    AddUebungView(split: split)
                }
                    .navigationTitle("Übung hinzufügen")
            }
            .sheet(isPresented: $showUebungListBeatz) {
                VordefinierteUebungen(split: split)
            }
        }
    }
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let uebung = split.getUebungen[index]
            moc.delete(uebung)
        }
        try? moc.save()
    }
    func moveItems(from source: IndexSet, to destination: Int) {
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Uebung.order, ascending: true)]) var uebungen: FetchedResults<Uebung>
        // Save changes to Core Data
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }
}
