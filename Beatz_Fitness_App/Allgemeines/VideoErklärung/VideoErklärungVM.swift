//
//  VideoErklärungVM.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 15.05.23.
//

import SwiftUI


struct Video: Identifiable {
    var id = UUID()
    let bild: Image
    let name: String
    let link: URL
    let beschreibung: String
}

struct VideoListe: View {
    let videos = [Bankdrücken, Squat]
    
    var body: some View {
        List(videos) { video in
            HStack {
                video.bild
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 90)
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text(video.name)
                        .font(.headline)
                    Text(video.beschreibung)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 12)
        }
        .navigationTitle("🏋🏻 Übungstutorials")
    }
}

let Bankdrücken = Video(bild: Image("TestBildGym"), name: "Bankdrücken", link: URL(string: "https://example.com")!, beschreibung: "von Dome")
let Squat = Video(bild: Image("TestBildGym"), name: "Squat", link: URL(string: "https://example.com")!, beschreibung: "von Vivi")
