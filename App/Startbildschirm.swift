//
//  Startbildschirm.swift
//  Beatz Fitness
//
//  Created by Maximillian Stabe on 22.03.23.
//

import SwiftUI

struct Startbildschirm: View {
    var body : some View {
        VStack {
            Image("BeatzLogo").resizable().padding(.top).scaledToFit()
            Text("Willkommen zurück!")
                
            Button(action: {
            }) {
                NavigationLink(destination: Hauptbildschirm()) {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue)
                        .cornerRadius(30)
                }
            }
        }
    }
}
