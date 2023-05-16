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
                    ForEach(splits.indices, id: \.self) { index in
                        let split = splits[index]
                        NavigationLink(destination: UebungView(split: split)) {
                            Text(split.name ?? "Error")
                        }
                        .swipeActions {
                            Button(action: {
                                deleteItems(at: IndexSet([index]))
                            }, label: {
                                Image(systemName: "trash")
                            })
                            .tint(.red)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                .padding()
                .listStyle(InsetListStyle())

                .navigationBarTitle("Trainingspläne")
                .navigationBarItems(leading:
                    Button(action: {
                    withAnimation {
                        isEditMode.toggle()

                    }
                    }) {
                        Text(isEditMode ? "Fertig" : "Bearbeiten")
                    }
                )
                .environment(\.editMode, isEditMode ? .constant(.active) : .constant(.inactive))
                .navigationBarItems(trailing:
                                        NavigationLink(destination:
                                                        AddSplitView(name: $name)) {
                    Image(systemName: "plus")
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
