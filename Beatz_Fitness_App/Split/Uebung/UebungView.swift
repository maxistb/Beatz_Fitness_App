//
//  SplitDetail.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//

import SwiftUI

struct UebungView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FocusState var isInputActive: Bool
    @FetchRequest(
        entity: Uebung.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Uebung.order, ascending: true)
        ]
    ) var uebungen: FetchedResults<Uebung>
    @State public var uebungenArray: [Uebung] = []
    var split: Split
    @State private var showAddUebungView = false
    @State private var showUebungListBeatz = false
    @State private var settingsDetent = PresentationDetent.medium
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Übungen")) {
                    ForEach(uebungen.filter({ $0.origin == split }), id: \.self) { uebung in
                        NavigationLink(
                            destination: EditUebungView(uebung: uebung),
                            label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(uebung.name ?? "Error")
                                        .font(.headline)
                                    HStack {
                                        if uebung.saetze == 1 {
                                            Text("\(uebung.saetze) Satz")
                                                .foregroundColor(.gray)
                                        }
                                        else if uebung.saetze != 1 {
                                            Text("\(uebung.saetze) Sätze")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    TextField("Notizen", text: Binding(
                                        get: {
                                            uebung.notizen ?? ""
                                        },
                                        set: { newValue in
                                            uebung.notizen = newValue
                                            try? moc.save()
                                        }
                                    ))
                                    .foregroundColor(.secondary)
                                    .focused($isInputActive)
                                }
                            }
                        )
                        
                        .swipeActions {
                            Button(action: {
                                deleteItems(at: IndexSet([split.getUebungen.firstIndex(of: uebung)].compactMap { $0 }))
                            }, label: {
                                Image(systemName: "trash")
                            })
                            .tint(.red)
                        }
                    }
                    .onMove(perform: moveItems)
                    
                }
                Section(header: Text("Notizen")) {
                    TextField("", text: Binding(
                        get: {
                            split.notizen ?? ""
                        },
                        set: { newValue in
                            split.notizen = newValue
                            try? moc.save()
                        }
                    ), axis: .vertical)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Fertig") {
                                isInputActive = false
                                try? moc.save()
                            }
                        }
                    }
                }

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
        .onAppear {
            uebungenArray = Array(uebungen)
        }
    }
}
