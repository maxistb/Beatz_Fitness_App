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
