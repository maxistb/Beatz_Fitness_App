//
//  VideoErklärung.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 23.04.23.
//

import SwiftUI
import AVKit

struct VideoErklärung: View {
    var body: some View {
        VideoListe()
        .navigationTitle("🏋🏻 Übungstutorials")
    }
}

struct Video: Identifiable {
    var id = UUID()
    let bild: Image
    let name: String
    let link: URL
    let beschreibung: String
}

let Bankdrücken = Video(bild: Image("TestBildGym"), name: "Bankdrücken", link: URL(string: "https://example.com")!, beschreibung: "von Dome")

struct VideoListe: View {
    let videos = [Bankdrücken]
    
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
                
                Spacer()
            }
            .padding(.vertical, 12)
        }
        .listStyle(InsetListStyle())
        .navigationTitle("🏋🏻 Übungstutorials")
    }
}



