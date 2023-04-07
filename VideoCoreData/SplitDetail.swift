//
//  SplitDetail.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 07.04.23.
//

import SwiftUI

struct SplitDetail: View {
    @Environment(\.managedObjectContext) var moc
    @StateObject var split: Split
    @State private var name = ""
    @State private var showingAddUebungView = false
    
    var body: some View {
        VStack {
            List(split.getUebungen) { uebung in
                HStack {
                    Text(uebung.name ?? "Error")
                    Text("\(uebung.saetze) Sätze")
                        .foregroundColor(.gray)
                        .font(.footnote)
                }
            }
            .navigationBarTitle(Text(split.name ?? "Error"))
            .navigationBarItems(trailing:
                Button(action: {
                    showingAddUebungView = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddUebungView) {
            AddUebungView(split: split, showingAddUebungView: $showingAddUebungView)
        }
    }
}

struct AddUebungView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var saetze = 0
    var split: Split
    @Binding var showingAddUebungView: Bool
    
    var body: some View {
        VStack {
            TextField("Übungsname", text: $name)
                .padding()
            
            HStack {
                Text("Sätze:")
                Stepper(value: $saetze, in: 0...20) {
                    Text("\(saetze)")
                }
            }
            .padding(.horizontal)
            
            Button("Speichern") {
                let neueUebung = Uebung(context: moc)
                neueUebung.id = UUID()
                neueUebung.name = name
                neueUebung.saetze = Int64(saetze)
                split.addToUebung(neueUebung)
                
                try? moc.save()
                name = ""
                saetze = 0
                showingAddUebungView = false
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10.0)
            .padding()
        }
        .navigationBarTitle("Übung hinzufügen")
        .navigationBarItems(trailing: Button(action: {
            showingAddUebungView = false
        }) {
            Text("Abbrechen")
        })
    }
}



