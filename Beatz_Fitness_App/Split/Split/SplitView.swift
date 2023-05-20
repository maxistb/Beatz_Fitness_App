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
    @State private var showAddSplitView = false
    @State private var settingsDetent = PresentationDetent.medium
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Eigene Splits")) {
                        ForEach(splits.indices, id: \.self) { index in
                            let split = splits[index]
                            NavigationLink(destination: UebungView(split: split)) {
                                if isEditMode {
                                    TextField("Split Name", text: Binding(
                                        get: {
                                            split.name ?? ""
                                        },
                                        set: { newName in
                                            updateSplitName(split: split, newName: newName)
                                        }
                                    ))
                                } else {
                                    Text(split.name ?? "Error")
                                }
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
                    Section(header: Text("Vordefinierte Splits")) {
                        // Add predefined splits here
                    }
                }
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
                                        Button(action: {
                    showAddSplitView = true
                }) {
                    Image(systemName: "plus")
                }
                )
            }
            .sheet(isPresented: $showAddSplitView) {
                NavigationView {
                    AddSplitView(name: $name)
                        .navigationBarBackButtonHidden(true)
                }
                    .presentationDetents(
                        [.medium, .large],
                        selection: $settingsDetent
                    )
                    .navigationViewStyle(StackNavigationViewStyle())
            }
            .navigationTitle("Split hinzufügen")
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}

