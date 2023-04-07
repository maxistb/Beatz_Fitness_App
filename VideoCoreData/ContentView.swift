//
//  ContentView.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var splits: FetchedResults<Split>
    @State private var name = ""
    @State private var showingAddSplitView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(splits) {split in
                        NavigationLink(destination: SplitDetail(split: split)) {
                            Text(split.name ?? "Error")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .padding()
                .listStyle(InsetListStyle())
                .navigationBarTitle("Trainingspläne")
                .navigationBarItems(trailing: addButton)
            }
        }
        .sheet(isPresented: $showingAddSplitView, content: {
            AddSplitView(name: $name, moc: _moc, showingAddSplitView: $showingAddSplitView)
        })
    }
    
    var addButton: some View {
        Button(action: {
            showingAddSplitView = true
        }) {
            Image(systemName: "plus")
        }
    }
    
    
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            let split = splits[offset]
            moc.delete(split)
        }
        try? moc.save()
    }
}


struct AddSplitView: View {
    
    @Binding var name: String
    @Environment(\.managedObjectContext) var moc
    @Binding var showingAddSplitView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Split Name", text: $name)
                    .padding()
                Button("Speichern") {
                    let neuerSplit = Split(context: moc)
                    neuerSplit.id = UUID()
                    neuerSplit.name = name
                    
                    try? moc.save()
                    name = ""
                    showingAddSplitView = false
                }
                .padding()
                .frame(width: 170)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15.0)
                .padding()
            }
            .navigationBarTitle("Split hinzufügen")
            .navigationBarItems(trailing: Button(action: {
                showingAddSplitView = false
            }) {
                Text("Abbrechen")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
