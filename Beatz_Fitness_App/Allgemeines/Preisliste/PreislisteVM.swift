//
//  PreislisteVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI


struct Angebot: Identifiable {
    let preis: Double
    let name: String
    let bild: Image
    let id = UUID()
}

let Shaker = Angebot(preis: 5.00, name: "Shaker", bild: Image("Beatz_Shaker"))
let Handtuch =  Angebot(preis: 5.00, name: "Handtuch", bild: Image("Beatz_Handtuch"))
let Shakes = Angebot(preis: 2.50, name: "Shakes", bild: Image("Beatz_Shakes"))
let ShakesHafermilch = Angebot(preis: 2.80, name: "Shakes Hafermilch", bild: Image("Beatz_ShakesHafermilch"))
let RiegelGroß = Angebot(preis: 2.50, name: "Riegel Groß", bild: Image("Beatz_RiegelGroß"))
let Espresso = Angebot(preis: 2.20, name: "Espresso", bild: Image("Beatz_Espresso"))
let CafeCreme = Angebot(preis: 2.30, name: "Café Creme", bild: Image("Beatz_CafeCreme"))
let Milchkaffee = Angebot(preis: 2.90, name: "Milchkaffee", bild: Image("Beatz_Milchkaffee"))
let DoppelterEspresso = Angebot(preis: 3.20, name: "Doppelter Espresso", bild: Image("Beatz_DoppelterEspresso"))
let LatteMacchiato = Angebot(preis: 3.30, name: "Latte Macchiato", bild: Image("Beatz_LatteMacchiato"))
let Tageskarte = Angebot(preis: 10.00, name: "Tageskarte", bild: Image("Beatz_Tageskarte"))
let PersonalTraining30 = Angebot(preis: 39.00, name: "Personal Training 30 Minuten", bild: Image("Beatz_PersonalTraining30"))
let PersonalTraining60 = Angebot(preis: 64.00, name: "Personal Training 60 Minuten", bild: Image("Beatz_PersonalTraining60"))
