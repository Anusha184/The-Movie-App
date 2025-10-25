//
//  Untitled.swift
//  MovieApp
//
//  Created by Anusha on 25/10/25.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct VideoPlayerView: UIViewRepresentable {
    let youtubeKey: String

    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.backgroundColor = .black
        return playerView
    }

    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        let playerVars: [String: Any] = [
            "playsinline": 1,
            "controls": 1,
            "autoplay": 0,
            "modestbranding": 1
        ]
        uiView.load(withVideoId: youtubeKey, playerVars: playerVars)
    }
}
