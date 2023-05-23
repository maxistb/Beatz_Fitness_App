//
//  VordefinierteUebungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI

extension VordefinierteUebungen {
    func addSelectedUebungen() {
        for uebung in selectedUebungen {
            let neueUebung = Uebung(context: moc)
            neueUebung.id = UUID()
            neueUebung.name = uebung.uebungName
            neueUebung.saetze = Int64(anzahlSaetze[uebungen.firstIndex(where: { $0.id == uebung.id })!])
            let newOrder = (split.uebung?.count ?? 0)
            neueUebung.order = Int64(newOrder)
            print("Order Übung: \(newOrder)")
            
            split.addToUebung(neueUebung)
        }
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct UebungsItem: Identifiable {
    var id = UUID()
    let uebungName: String
    let uebungBeschreibung: String
    var anzahlSaetze: Int
    let bild: Image
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}

var uebungen = [
    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
    UebungsItem(uebungName: "Squat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("TestBild")),
    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("BeatzLogo")),
    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat"))
]
