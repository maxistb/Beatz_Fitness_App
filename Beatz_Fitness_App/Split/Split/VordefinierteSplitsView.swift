//
//  VordefinierteSplitsView.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 17.05.23.
//

import SwiftUI

struct VordefinierteSplitsView: View {
    @Environment(\.managedObjectContext) var moc

    var split1: Split?
    var split2: Split?

    init() {
        split1 = nil
        split2 = nil
        createSplits()
    }

    var body: some View {
        List {
            NavigationLink("Push", destination: TrainerListeView())
        }
    }

    mutating func createSplits() {
        split1 = Split(context: moc)
        split1?.id = UUID()
        split1?.name = "Split 1"

        split2 = Split(context: moc)
        split2?.id = UUID()
        split2?.name = "Split 2"
    }
}









