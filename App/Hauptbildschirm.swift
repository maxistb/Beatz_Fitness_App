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
                    Image(systemName: "list.clipboard.fill")
                    Text("Trainingspläne")
                    
                }
            Diagramme()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    Text("Fortschritte")
                }
            KursplanView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Kursplan")
                }
            Einstellungen()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Einstellungen")
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

struct EinstellungenView: View {
    var body: some View {
        Einstellungen()
    }
}


struct Hauptbildschirm_Previews: PreviewProvider {
    static var previews: some View {
        Hauptbildschirm()
    }
}
