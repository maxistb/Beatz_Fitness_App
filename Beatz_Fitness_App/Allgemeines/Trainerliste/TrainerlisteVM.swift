//
//  TrainerlisteVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI

struct Trainer: Identifiable {
    var id = UUID()
    let name: String
    let bild: Image
    let aufgabe: String
}

let Vivi = Trainer(name: "Vivi", bild: Image("Beatz_Vivi"), aufgabe: "Training")
let Finja = Trainer(name: "Finja", bild: Image("Beatz_Finja"), aufgabe: "Personal Training")
let Larissa = Trainer(name: "Larissa", bild: Image("Beatz_Larissa"), aufgabe: "Training")
let Birte = Trainer(name: "Birte", bild: Image("Beatz_Birte"), aufgabe: "Studioleitung")
let Dome = Trainer(name: "Dome & Rike", bild: Image("Beatz_Dome"), aufgabe: "Inhaber des Beatz")
let Ranjid = Trainer(name: "Ranjid", bild: Image("Beatz_Ranjid"), aufgabe: "Putzkraft")
let Anny = Trainer(name: "Anny", bild: Image("Beatz_Anny"), aufgabe: "")
