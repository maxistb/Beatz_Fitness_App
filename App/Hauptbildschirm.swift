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
            SplitView()
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text("Trainingspläne")
                }
            TrainingHistorieView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    Text("Historie")
                }
            Trainingstagebuch()
                .tabItem {
                    Image(systemName: "trophy")
                    Text("Training")
                }
//            StatistikView()
//                .tabItem {
//                    Image(systemName: "calendar")
//                    Text("Statistiken")
//                }
//            
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



