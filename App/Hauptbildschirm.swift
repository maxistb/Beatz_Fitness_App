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
            TrainingHistorie()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    Text("Historie")
                }
            Trainingstagebuch()
                .tabItem {
                    Image(systemName: "trophy")
                    Text("Training")
                }
            Allgemeines()
                .tabItem {
                    Image(systemName: "info.bubble")
                    Text("Allgemeines")
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

struct EinstellungenView: View {
    var body: some View {
        Allgemeines()
    }
}

struct TrainingstagebuchView: View {
    var body: some View {
        Trainingstagebuch()
    }
}

struct Hauptbildschirm_Previews: PreviewProvider {
    static var previews: some View {
        Hauptbildschirm()
    }
}
