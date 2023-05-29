//
//  AddSplitView.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//

import SwiftUI

struct AddSplitView: View {
    @Binding var name: String
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name vom Split", text: $name)
                }
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button("Speichern") {
                            let newOrder = (try? moc.fetch(Split.fetchRequest()).count) ?? 0
                            
                            let neuerSplit = Split(context: moc)
                            neuerSplit.id = UUID()
                            neuerSplit.name = name
                            neuerSplit.order = Int64(newOrder)
                            print(newOrder)
                            
                            try? moc.save()
                            name = ""
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(width: 200)
                        .background(Color(red: 0/255, green: 166/255, blue: 205/255))
                        .cornerRadius(15.0)
                        
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
            }
        }
        .navigationBarTitle("Split hinzufügen")
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("")
            }
        )
    }
}

