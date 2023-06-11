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
    private let player = AVPlayer(url: Bundle.main.url(forResource: "Beatz_Video-Fertig", withExtension: "mp4")!)
    private let playerLayer = AVPlayerLayer()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .onAppear {
                    player.play()
                }
                .frame(width: frameWidth, height: frameHeight)
                .allowsHitTesting(false)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Image("Beatz_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoWidth, height: logoHeight)
                Spacer()
                Button(action: {
                    showMainScreen = true
                }) {
                    Text("Starten")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: buttonWidth, height: buttonHeight)
                        .background(Color(red: 0/255, green: 166/255, blue: 205/255))
                        .cornerRadius(15)
                }
                .padding(.bottom, buttonBottomPadding)
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
    }
    
    private var frameWidth: CGFloat {
        switch horizontalSizeClass {
        case .compact:
            return 900
        case .regular:
            return 1000
        default:
            return 900
        }
    }
    
    private var frameHeight: CGFloat {
        switch verticalSizeClass {
        case .compact:
            return 900
        case .regular:
            return 1000
        default:
            return 900
        }
    }
    
    private var logoWidth: CGFloat {
        switch horizontalSizeClass {
        case .compact:
            return 350
        case .regular:
            return 350
        default:
            return 350
        }
    }
    
    private var logoHeight: CGFloat {
        switch verticalSizeClass {
        case .compact:
            return 350
        case .regular:
            return 350
        default:
            return 350
        }
    }
    
    private var buttonWidth: CGFloat {
        switch horizontalSizeClass {
        case .compact:
            return 250
        case .regular:
            return 300
        default:
            return 200
        }
    }
    
    private var buttonHeight: CGFloat {
        switch verticalSizeClass {
        case .compact:
            return 50
        case .regular:
            return 50
        default:
            return 50
        }
    }
    
    private var buttonBottomPadding: CGFloat {
        switch verticalSizeClass {
        case .compact:
            return 100
        case .regular:
            return 200
        default:
            return 150
        }
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
