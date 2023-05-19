//
//  VordefinierteSplitsView.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.05.23.
//

import SwiftUI

import SwiftUI

struct VordefinierteSplitsView: View {
    let vordefinierteSplits: [VordefinierterSplit] = [
        VordefinierterSplit(name: "Push", uebung: ["Bankdrücken", "Brustpresse"]),
        VordefinierterSplit(name: "Pull", uebung: ["Klimmzüge", "Rudern"])
    ]

    var body: some View {
        List {
            NavigationLink("Push", destination: TrainerListeView()) 
        }
    }
}

struct VordefinierterSplit {
    let name: String
    let uebung: [String]
}



