//
//  YouTubeView.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 31/12/25.
//

import SwiftUI
import YouTubePlayerKit

struct YouTubeView: View {
    var youTubePlayer: YouTubePlayer = ""

    init (youtubeID: String) {
        self.youTubePlayer = YouTubePlayer(
            source: .video(
                id: youtubeID
            ),
            parameters: .init(
                autoPlay: true,
                loopEnabled: true,
                showControls: true,
                showFullscreenButton: true,
            )
        )
    }
    
    var body: some View {
        YouTubePlayerView(self.youTubePlayer) { state in
            switch state {
            case .idle:
                ProgressView()
            case .ready:
                EmptyView()
            case .error(let error):
                ContentUnavailableView(
                    "Error",
                    systemImage: "exclamationmark.triangle.fill",
                    description: Text(
                        "YouTube player couldn't be loaded: \(error.localizedDescription)"
                    )
                )
            } 
        }
        .ignoresSafeArea()
    }
}
