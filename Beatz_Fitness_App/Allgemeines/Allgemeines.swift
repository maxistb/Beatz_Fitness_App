//
//  Einstellungen.swift
//  VideoCoreData
//
//  Created by Maximillian Stabe on 08.04.23.
//

import SwiftUI

struct Allgemeines: View {
    @State private var showSettings = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Kursplan & Unsere Trainer")) {
                    NavigationLink(destination: Kursplan(viewModel: KursplanViewModel())) {
                        HStack {
                            Image("BeatzKursplan")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .cornerRadius(40)
                            Text("Unser Kursplan")
                        }
                    }
                    
                    NavigationLink(destination: TrainerListeView()) {
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
                
                Section(header: Text("Videotutorials")) {
                    NavigationLink(destination: VideoErklärungView()) {
                        HStack {
                            Image("BeatzLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .cornerRadius(40)
                            Text("Tutorials zu allen Übungen")
                        }
                    }
                }
                
                Section(header: Text("Trainerzeiten")) {
                    Text("Montag bis Freitag: 8 - 13 & 15 - 20 Uhr")
                    
                }
                
//                Section(header: Text("Preisliste")) {
//                    NavigationLink(destination: Preisliste()) {
//                        HStack {
//                            Image("BeatzLogo")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 40, height: 40)
//                                .cornerRadius(40)
//                            Text("Preisliste")
//                        }
//                    }
//                }
                
                Section(header: Text("Kontaktiere uns!")) {
                    HStack {
                        Link(destination: URL(string: "https://www.instagram.com/beatzfitness_elmshorn/")!) {
                            HStack {
                                Text("Instagram @beatzfitness_elmshorn")
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                        }
                    }
                    Link(destination: URL(string:
                                            "https://beatz-fitness.de")!) {
                        HStack {
                            Text("Website beatz-fitness.de")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                        }
                    }
                }
                Section(header: Text("App entwickelt von")) {
                    Text("Maximillian Stabe")
                }
            }
            .navigationTitle("Allgemeines")
        }
    }
}

struct EinstellungenPreviews: PreviewProvider {
    static var previews: some View {
        Allgemeines()
    }
}
