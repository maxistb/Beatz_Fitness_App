//
//  AddUebung.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//

import SwiftUI

struct AddUebungView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var saetze = 1
    var split: Split
    
    var body: some View {
        VStack {
            List {
                TextField("Übungsname", text: $name)
                
                Section {
                    HStack {
                        Text("Sätze:")

                        Stepper(value: $saetze, in: 1...20) {
                            Text("\(saetze)")
                        }
                    }
                }
                .padding(.horizontal)
                
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button("Speichern") {
                            let neueUebung = Uebung(context: moc)
                            neueUebung.id = UUID()
                            neueUebung.name = name
                            neueUebung.saetze = Int64(saetze)
                            split.addToUebung(neueUebung)
                            
                            try? moc.save()
                            name = ""
                            saetze = 1
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
        .navigationBarTitle("Übung hinzufügen")
    }
}


struct UebungPreview: PreviewProvider {
    static var previews: some View {
    SplitView()
    }
}
