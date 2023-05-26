//
//  WelcomeVideo.swift
//  Beatz_Fitness_App
//
//  Created by Maximillian Stabe on 25.05.23.
//

import SwiftUI
import AVKit
import AVFoundation

struct WelcomeView: View {
    @State private var showMainScreen = false
    private let player = AVPlayer(url: Bundle.main.url(forResource: "Beatz_Video-Edited", withExtension: "mp4")!)
    private let playerLayer = AVPlayerLayer()

    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .onAppear {
                    player.play()
                }
                .frame(width: 900, height: 900)
                .allowsHitTesting(false)

            VStack {
                Spacer()
                Button(action: {
                    showMainScreen = true
                }) {
                    Text("Starten")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .padding(.bottom, 100)
            }
        }
        .onAppear {
            playerLayer.player = player
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.frame = UIScreen.main.bounds

            configureAudioSession()
            player.play()
        }

        .onDisappear {
            player.pause()
            playerLayer.removeFromSuperlayer()
        }

        .fullScreenCover(isPresented: $showMainScreen, content: {
            Hauptbildschirm()
        })
        .edgesIgnoringSafeArea(.all)
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
}
