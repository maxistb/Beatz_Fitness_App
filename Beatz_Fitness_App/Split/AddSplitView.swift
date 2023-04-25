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
            ZStack {
                Form {
                    Section(header: Text("Name des Trainingsplans")) {
                        TextField("Name", text: $name)
                    }
                }
                
                Button("Speichern") {
                    let neuerSplit = Split(context: moc)
                    neuerSplit.id = UUID()
                    neuerSplit.name = name
                    
                    try? moc.save()
                    name = ""
                    
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .frame(width: 170)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15.0)
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

struct AddSplitPreview: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}


