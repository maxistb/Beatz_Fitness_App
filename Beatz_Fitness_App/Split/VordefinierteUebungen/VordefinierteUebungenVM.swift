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
            neueUebung.saetze = Int64(anzahlSaetze[uebungenBeine.firstIndex(where: { $0.id == uebung.id }) ?? 1])
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

var uebungenBeine = [
    UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 2, bild: Image("Hacksquat")),
    UebungsItem(uebungName: "Wadenmaschine", uebungBeschreibung: "Für die Waden", anzahlSaetze: 2, bild: Image("Wadenmaschine_alt")),
    UebungsItem(uebungName: "Kickbackmaschine", uebungBeschreibung: "Für den Po", anzahlSaetze: 2, bild: Image("Kickbackmaschine")),
    UebungsItem(uebungName: "Beinstrecker schwer", uebungBeschreibung: "Für die Quads", anzahlSaetze: 2, bild: Image("Beinstrecker_neu")),
    UebungsItem(uebungName: "Beinpressmaschine", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Beinpressmaschine")),
    UebungsItem(uebungName: "Beinpresse", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Beinpresse")),
    UebungsItem(uebungName: "Adduktormaschine", uebungBeschreibung: "Für die Adduktoren", anzahlSaetze: 2, bild: Image("Adduktormaschine")),
    UebungsItem(uebungName: "Abduktormaschine", uebungBeschreibung: "Für die Abduktoren", anzahlSaetze: 2, bild: Image("Abduktormaschine"))
]

var uebungenRücken = [
    UebungsItem(uebungName: "T-Bar Row", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("T-Bar")),
    UebungsItem(uebungName: "Rudern", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Rudern")),
    UebungsItem(uebungName: "Reverse Butterfly", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Reverse_Butterfly")),
    UebungsItem(uebungName: "Latzugmaschine", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Latzugmaschine")),
    UebungsItem(uebungName: "Latzug", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Latzug")),
    UebungsItem(uebungName: "Klimmzug unterstützt", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Klimmzugmaschine")),
    UebungsItem(uebungName: "Highrow", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Highrow"))
]

var uebungenBrust = [
    UebungsItem(uebungName: "Dip unterstützt", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Klimmzugmaschine")),
    UebungsItem(uebungName: "Schulterpresse", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("FullSizeRender")),
    UebungsItem(uebungName: "Dipmaschine", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Dipmaschine")),
    UebungsItem(uebungName: "Butterfly", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Butterfly")),
    UebungsItem(uebungName: "Brustpresse", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Brustpresse")),
    UebungsItem(uebungName: "Bankdrückmaschine", uebungBeschreibung: "Für den Lat", anzahlSaetze: 2, bild: Image("Bankdrückmaschine"))
]


