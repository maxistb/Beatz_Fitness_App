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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}