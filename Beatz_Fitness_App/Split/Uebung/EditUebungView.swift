//
//  EditUebungView.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 19.05.23.
//

import SwiftUI

struct EditUebungView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    var uebung: Uebung
    @State private var notizenUebung = ""
    @State private var saetze: Int64
    
    init(uebung: Uebung) {
        self.uebung = uebung
        self._saetze = State(initialValue: uebung.saetze)
    }
    
    var body: some View {
        VStack {
            List {
                TextField("Übungsname", text: Binding(
                    get: {
                        uebung.name ?? ""
                    },
                    set: { newValue in
                        uebung.name = newValue
                        try? moc.save()
                    }
                ))
                .onChange(of: uebung.name) { _ in
                    try? moc.save()
                }
                
                Section(header: Text("Notizen")) {
                    TextField("Notizen", text: Binding(
                        get: {
                            uebung.notizen ?? ""
                        },
                        set: { newValue in
                            uebung.notizen = newValue
                            try? moc.save()
                        }
                    ))
                    .onChange(of: uebung.notizen) { _ in
                        try? moc.save()
                    }
                }
                
                Section {
                    HStack {
                        Text("Sätze:")
                        
                        Stepper(value: $saetze, in: 1...20) {
                            Text("\(saetze)")
                        }
                    }
                }
                
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button("Speichern") {
                            uebung.name = uebung.name
                            uebung.saetze = Int64(saetze)
                            
                            try? moc.save()
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
            .navigationBarTitle("Übung bearbeiten")
            .onDisappear {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

