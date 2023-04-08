//
//  ContentView.swift
//  Beatz Fitness
//
//  Created by Maximillian Stabe on 22.03.23.
//

import SwiftUI


struct Hauptbildschirm: View {
    var body: some View {
        TabView {
            TrainingssplitView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Trainingspläne")
                    
                }
            FortschritteView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Fortschritte")
                }
            TrainerView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Trainer")
                }
            KursplanView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Kursplan")
                }
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(.blue)
        
    }
    
}


struct TrainingssplitView: View {
    var body: some View {
        SplitView()
    }
}

struct FortschritteView: View {
    var body: some View {
           Diagramme()
        }
    }



struct TrainerView: View {
    var body: some View {
        TrainerListe()
    }
}

struct KursplanView: View {
    var body: some View {
        Kursplan()
    }
}



struct Hauptbildschirm_Previews: PreviewProvider {
    static var previews: some View {
        Hauptbildschirm()
    }
}
