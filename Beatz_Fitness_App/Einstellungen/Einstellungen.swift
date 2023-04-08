//
//  Einstellungen.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 08.04.23.
//

import SwiftUI

struct Einstellungen: View {
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("Trainer im Beatz")) {
                        NavigationLink(destination: TrainerView()) {
                            HStack {
                                Image("Beatz_Dome")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(40)
                                Text("Unsere Trainer")
                            }
                        }
                    }
                    
                    Section(header: Text("Folge uns auf Instagram!")) {
                        HStack {
                            Link(destination: URL(string: "https://www.instagram.com/beatzfitness_elmshorn/")!) {
                                HStack {
                                    Text("@BeatzFitness_Elmshorn")
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                }
                            }
                        }
                    }
                    Section(header: Text("App entwickelt von")) {
                        Text("Maximillian Stabe")
                    }
                }
            .navigationTitle("Einstellungen")
        }
    }
}

struct EinstellungenPreviews: PreviewProvider {
    static var previews: some View {
        Einstellungen()
    }
}

