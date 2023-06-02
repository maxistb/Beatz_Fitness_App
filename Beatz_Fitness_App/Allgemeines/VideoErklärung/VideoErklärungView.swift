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
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        HStack {
//                            Text("⚙ Allgemeines")
//                        }
//                    }
//                }
//        }
    }
}








