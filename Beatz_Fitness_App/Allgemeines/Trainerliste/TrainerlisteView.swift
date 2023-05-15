//
//  Trainer.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 25.03.23.
//

import SwiftUI

struct TrainerListeView: View {
    let trainers = [Dome, Vivi, Finja, Larissa, Birte, Ranjid, Anny]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(trainers, id: \.name) { trainer in
                    HStack {
                        trainer.bild
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
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
                    Divider()
                }
            }
        }
        .navigationTitle("💪🏼 Unsere Trainer")
    }
}



struct Trainer_Preview: PreviewProvider {
    static var previews: some View {
        TrainerListeView()
    }
}
