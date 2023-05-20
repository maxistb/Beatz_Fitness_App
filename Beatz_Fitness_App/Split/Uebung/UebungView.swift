//
//  SplitDetail.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//

import SwiftUI

struct UebungView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
           entity: Uebung.entity(),
           sortDescriptors: [
               NSSortDescriptor(keyPath: \Uebung.name, ascending: true)
           ]
       ) var uebungen: FetchedResults<Uebung>
       
       var split: Split
       @State private var name = ""
       @State private var showAddUebungView = false
       @State private var showUebungListBeatz = false
       @State private var settingsDetent = PresentationDetent.medium
       @State private var notizenSplit = ""
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Übungen")) {
                    ForEach(uebungen.filter({ $0.origin == split }), id: \.self) { uebung in
                        NavigationLink(
                            destination: EditUebungView(uebung: uebung),
                            label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(uebung.name ?? "Error")
                                        Text("\(uebung.saetze) Sätze")
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                        Spacer()
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
                    TextEditor(text: $notizenSplit)
                        .frame(height: 150)
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
    }
}
