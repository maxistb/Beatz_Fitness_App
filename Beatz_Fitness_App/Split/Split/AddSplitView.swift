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
                            let neuerSplit = Split(context: moc)
                            neuerSplit.id = UUID()
                            neuerSplit.name = name
                            
                            try? moc.save()
                            name = ""
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(width: 200)
                        .background(Color.blue)
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
