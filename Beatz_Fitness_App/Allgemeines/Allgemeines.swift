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
                            Text("Unser Kursplan 📅")
                        }
                    }
                    
                    NavigationLink(destination: TrainerListeView()) {
                        HStack {
                            Image("Beatz_Dome")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .cornerRadius(40)
                            Text("Unsere Trainer 💪🏼")
                        }
                    }
                }
                
                Section(header: Text("Übungstutorials")) {
                    NavigationLink(destination: VideoErklärungView()) {
                        HStack {
                            Image("Beatz_Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .cornerRadius(40)
                            Text("Übungstutorials 🎥")
                        }
                    }
                }
                
                Section(header: Text("Trainerzeiten ⌛️")) {
                    Text("Montag bis Freitag: 8 - 13 & 15 - 20 Uhr")
                    Text("Wochenende: 10 - 14 Uhr, feiertags frei")
                    
                }
                
                Section(header: Text("Saunazeiten 🧖🏼‍♂️")) {
                    Text("Montag bis Freitag: 8 - 13 & 15 - 21 Uhr")
                    Text("Wochenende: 10 - 14 Uhr, feiertags frei")
                    
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
            .navigationBarTitle("ℹ️ Allgemeines")
            .navigationBarTitle("Zurück")
        }
        .accentColor(Color(red: 0/255, green: 166/255, blue: 205/255))
    }
}

struct EinstellungenPreviews: PreviewProvider {
    static var previews: some View {
        Allgemeines()
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

//     To make it works also with ScrollView
     public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         true
     }

// To make it works also with ScrollView but not simultaneously
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        true
//    }
}
