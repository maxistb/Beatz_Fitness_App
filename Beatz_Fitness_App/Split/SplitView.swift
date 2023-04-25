///
//  ContentView.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 05.04.23.
//

import SwiftUI
import CoreData

struct SplitView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var splits: FetchedResults<Split>
    @State private var name = ""
    @State private var isEditMode = false
    
    var body: some View {
 
        NavigationView {
            VStack {
                List {
                    ForEach(splits) {split in
                        NavigationLink(destination: UebungView(split: split)) {
                            Text(split.name ?? "Error")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                .padding()
                .listStyle(InsetListStyle())

                .navigationBarTitle("Trainingspläne")
                .navigationBarItems(trailing:
                                        NavigationLink(destination:
                                                        AddSplitView(name: $name)) {
                    Image(systemName: "plus")
                }
                )
                .navigationBarItems(leading:
                    EditButton()
                        .onTapGesture {
                            isEditMode.toggle()
                        }
                )
            }
        }
    }
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            let split = splits[offset]
            moc.delete(split)
        }
        try? moc.save()
    }
    
    
    func moveItems(from source: IndexSet, to destination: Int) {
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Split.order, ascending: true)]) var splits: FetchedResults<Split>

        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}
