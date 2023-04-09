//
//  Trainer.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 25.03.23.
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
let Anny = Trainer(name: "Anny", bild: Image("Beatz_Anny"), aufgabe: "Aufpasser")


struct TrainerListe: View {
    let trainers = [Dome, Vivi, Finja, Larissa, Birte, Ranjid, Anny]
    
    var body: some View {
        NavigationView {
            VStack {
                List(trainers) { trainer in
                    HStack {
                        trainer.bild
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .cornerRadius(40)
                        
                        VStack(alignment: .trailing) {
                            Text(trainer.name)
                                .frame(width: 250)
                                .font(.title3)
                            
                            Text(trainer.aufgabe)
                                .frame(width: 250)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Unsere Trainer")
        }
    }
}


struct Trainer_Preview: PreviewProvider {
    static var previews: some View {
        TrainerListe()
    }
}
