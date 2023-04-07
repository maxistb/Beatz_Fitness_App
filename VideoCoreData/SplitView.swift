//
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
                .navigationBarItems(trailing:
                                        NavigationLink(destination: AddSplitView(name: $name)) {
                    Image(systemName: "plus")
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
}


struct AddSplitView: View {
    @Binding var name: String
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
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
                }
                .padding()
                .frame(width: 170)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15.0)
                .padding()
            }
            
        }
        .navigationBarTitle("Split hinzufügen")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Trainingspläne")
            }
        }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       SplitView()
    }
}
