//
//  UebungListBeatz.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 08.04.23.
//

import SwiftUI

let Hacksquat = UebungListeBeatz(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat"))

struct UebungListBeatz: View {
    let uebungen = [Hacksquat]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Beine")) {
                    List(uebungen) {uebung in
                        HStack {
                            uebung.bild
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                            
                            VStack(alignment: .trailing) {
                                Text(uebung.uebungName)
                                    .frame(width: 250)
                                    .font(.title3)

                                Text(uebung.uebungBeschreibung)
                                    .frame(width: 250)
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                    }
                }
                Section(header: Text("Brust")) {
                }
                Section(header: Text("Rücken")) {
                }
                Section(header: Text("Bizeps")) {
                }
                Section(header: Text("Trizeps")) {
                }
                Section(header: Text("Schulter")) {
                }
                Section(header: Text("Bauch")) {
                }
            }
            .navigationTitle("Übungen")
        }
    }
}


struct UebungListPreviews: PreviewProvider {
    static var previews: some View {
        UebungListBeatz()
    }
}

struct UebungListeBeatz: Identifiable {
    var id = UUID()
    let uebungName: String
    let uebungBeschreibung: String
    let anzahlSaetze: Int
    let bild: Image
}
