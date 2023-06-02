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
                    Image(systemName: "book")
                    Text("Trainingstagebuch")
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
                    Text("Allgemein")
                }
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(Color(red: 0/255, green: 166/255, blue: 205/255))
    }
}



