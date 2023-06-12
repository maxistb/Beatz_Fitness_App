//
//  SplitVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI

extension SplitView {
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let split = splits[index]
            moc.delete(split)
        }
        try? moc.save()
        
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        var revisedSplits: [Split] = splits.map { $0 }
        revisedSplits.move(fromOffsets: source, toOffset: destination)
        
        for index in 0..<revisedSplits.count {
            revisedSplits[index].order = Int64(index)
        }
        
        for split in revisedSplits {
            split.order = split.order
            print("\(split.name ?? "") \(split.order)")
            
        }
        try? moc.save()
    }
    
    func updateSplitName(split: Split, newName: String) {
        moc.performAndWait {
            split.name = newName
            try? moc.save()
        }
    }
}

class SplitViewModel: ObservableObject {
    @Published var vordefinierteSplitsMänner: [VordefinierteSplits] = [
        VordefinierteSplits(
            name: "Push",
            uebungen: [
                UebungsItem(uebungName: "Brustpresse", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Brustpresse")),
                UebungsItem(uebungName: "Butterfly", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Butterfly")),
                UebungsItem(uebungName: "Seitheben", uebungBeschreibung: "Schultern", anzahlSaetze: 3, bild: Image("Seithebenmaschine")),
                UebungsItem(uebungName: "Schulterpresse", uebungBeschreibung: "Schultern", anzahlSaetze: 3, bild: Image("FullSizeRender")),
                UebungsItem(uebungName: "Trizeps Pushdown", uebungBeschreibung: "Trizeps", anzahlSaetze: 3, bild: Image("Butterfly"))
            ]
        ),
        VordefinierteSplits(
            name: "Pull",
            uebungen: [
                UebungsItem(uebungName: "Latzug", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Latzug")),
                UebungsItem(uebungName: "T-Bar Row", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("T-Bar")),
                UebungsItem(uebungName: "Highrow", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Highrow")),
                UebungsItem(uebungName: "Rückenstrecker", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Reverse_Butterfly")),
                UebungsItem(uebungName: "Reverse Butterfly", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Reverse_Butterfly")),
                UebungsItem(uebungName: "Bizepsmaschine", uebungBeschreibung: "Bizeps", anzahlSaetze: 3, bild: Image("Reverse_Butterfly")),
            ]
        ),
        VordefinierteSplits(
            name: "Oberkörper",
            uebungen: [
                UebungsItem(uebungName: "T-Bar Row", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("T-Bar")),
                UebungsItem(uebungName: "Rudern", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Rudern")),
                UebungsItem(uebungName: "Latzug", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Latzug")),
                UebungsItem(uebungName: "Butterfly", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Butterfly")),
                UebungsItem(uebungName: "Bankdrückmaschine", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Bankdrückmaschine"))
            ]
        ),
        VordefinierteSplits(
            name: "Unterkörper",
            uebungen: [
                UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Hacksquat")),
                UebungsItem(uebungName: "Beinpresse", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Beinpresse")),
                UebungsItem(uebungName: "Beinbeuger", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Beinpresse")),
                UebungsItem(uebungName: "Wadenmaschine", uebungBeschreibung: "Waden", anzahlSaetze: 3, bild: Image("Wadenmaschine_alt"))
            ]
        ),
        VordefinierteSplits(
            name: "Ganzkörper",
            uebungen: [
                UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Beine", anzahlSaetze: 3, bild: Image("Hacksquat")),
                UebungsItem(uebungName: "Rudern", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Rudern")),
                UebungsItem(uebungName: "Butterfly", uebungBeschreibung: "Latissimus", anzahlSaetze: 3, bild: Image("Butterfly")),
                UebungsItem(uebungName: "Bankdrückmaschine", uebungBeschreibung: "Brust", anzahlSaetze: 3, bild: Image("Bankdrückmaschine")),
                UebungsItem(uebungName: "Schulterpresse", uebungBeschreibung: "Schultern", anzahlSaetze: 3, bild: Image("FullSizeRender"))
            ]
        ),
    ]
    
    @Published var vordefinierteSplitsFrauen: [VordefinierteSplits] = [
        VordefinierteSplits(
            name: "Beine",
            uebungen: [
                UebungsItem(uebungName: "Hacksquat", uebungBeschreibung: "Für die Beine", anzahlSaetze: 3, bild: Image("Hacksquat")),
                UebungsItem(uebungName: "Beinpresse", uebungBeschreibung: "Für den Lat", anzahlSaetze: 3, bild: Image("Beinpresse")),
                UebungsItem(uebungName: "Beinbeuger", uebungBeschreibung: "Für den Lat", anzahlSaetze: 3, bild: Image("Beinpresse")),
                UebungsItem(uebungName: "Beinstrecker schwer", uebungBeschreibung: "Für die Quads", anzahlSaetze: 3, bild: Image("Beinstrecker_neu")),
                UebungsItem(uebungName: "Adduktormaschine", uebungBeschreibung: "Für die Adduktoren", anzahlSaetze: 3, bild: Image("Adduktormaschine")),
                UebungsItem(uebungName: "Wadenmaschine", uebungBeschreibung: "Für die Waden", anzahlSaetze: 3, bild: Image("Wadenmaschine_alt")),
            ]
        ),
    ]
}

