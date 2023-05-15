//
//  PreislisteView.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 14.05.23.
//

import SwiftUI

struct Preisliste: View {
    let angebote = [
        Shaker, Handtuch, Shakes, ShakesHafermilch, RiegelGroß, Espresso, CafeCreme, Milchkaffee, DoppelterEspresso, LatteMacchiato, Tageskarte, PersonalTraining30, PersonalTraining60
    ]

    var body: some View {
            VStack {
                List(angebote) { angebot in
                    HStack {
                        angebot.bild
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(40)

                        VStack(alignment: .trailing) {
                            Text(angebot.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3)

                            HStack(spacing: 0) {
                                Text(String(format: "%.2f", angebot.preis) + "€")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.secondary)

                                Spacer()
                            }
                            .frame(width: 250)
                        }
                    }
                }
            }
        .navigationTitle(" Preisliste")
    }
}

