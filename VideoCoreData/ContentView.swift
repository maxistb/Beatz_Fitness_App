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
                HStack {
                    TextField("Add Split", text: $name)
                        .padding(.leading)
                    Button("Add") {
                        let neuerSplit = Split(context: moc)
                        neuerSplit.id = UUID()
                        neuerSplit.name = name
                        
                        try? moc.save()
                        name = ""
                    }
                }
            }
            .padding()
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

struct SplitDetail: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var split: Split
    @State private var name = ""
    
    var body: some View {
        VStack {
            List(split.getUebungen) {uebungen in
                HStack {
                    Text(uebungen.name ?? "Error")
                }
            }
            
            HStack {
                TextField("Add Uebung", text: $name)
                    .padding(.leading)
                Button("Add") {
                    let neueUebung = Uebung(context: moc)
                    neueUebung.id = UUID()
                    neueUebung.name = name
                    split.addToUebung(neueUebung)
                    
                    try? moc.save()
                    name = ""
                }
                .padding(.trailing)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
