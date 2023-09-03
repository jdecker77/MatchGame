//
//  MatchGameApp.swift
//  MatchGame
//
//  Created by Jesse Decker on 8/25/23.
//

import SwiftUI

@main
struct MatchGameApp: App {
    @StateObject var game = EmojiMatchGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMatchGameView(viewModel: game)
        }
    }
}
