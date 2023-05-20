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
    @State private var aufwaermsaetze: Int64
    @State private var dropsaetze: Int64

    
    init(uebung: Uebung) {
        self.uebung = uebung
        self._aufwaermsaetze = State(initialValue: uebung.aufwaermsaetze)
        self._dropsaetze = State(initialValue: uebung.dropsaetze)
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
                    HStack {
                        Text("Aufwärmsätze:")
                        
                        Stepper(value: $aufwaermsaetze, in: 0...20) {
                            Text("\(aufwaermsaetze)")
                        }
                    }
                    HStack {
                        Text("Dropsätze:")
                        
                        Stepper(value: $dropsaetze, in: 0...20) {
                            Text("\(dropsaetze)")
                        }
                    }
                }
                
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button("Speichern") {
                            uebung.name = uebung.name
                            uebung.saetze = Int64(saetze)
                            uebung.dropsaetze = Int64(dropsaetze)
                            uebung.aufwaermsaetze = Int64(aufwaermsaetze)
                            
                            try? moc.save()
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
            .navigationBarTitle("Übung bearbeiten")
            .onDisappear {
                          // Aktualisiere die UebungView, wenn die EditUebungView ausgeblendet wird
                          presentationMode.wrappedValue.dismiss()
                      }
        }
    }
}

