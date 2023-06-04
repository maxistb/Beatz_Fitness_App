//
//  VideoErklärungView.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 23.04.23.
//

import SwiftUI
import AVKit

struct VideoErklärungView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            VideoListe()
                .navigationTitle("🎥 Übungstutorials")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
    }
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("ℹ️ Allgemeines")
            }
        }
    }
}








