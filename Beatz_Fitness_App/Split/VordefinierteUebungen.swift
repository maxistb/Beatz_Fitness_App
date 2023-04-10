//
//  VordefinierteUebungen.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 10.04.23.
//

import SwiftUI

struct UebungsItem: Identifiable {
    var id = UUID()
    let uebungName: String
    let uebungBeschreibung: String
    var anzahlSaetze: Int
    let bild: Image
    var isChecked: Bool = false
}


