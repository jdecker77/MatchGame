//
//  EmojiMatchGame.swift
//  MatchGame
//
//  Created by Jesse Decker on 8/26/23.
//

import SwiftUI

class EmojiMatchGame: ObservableObject {
    
    private static let emojis = ["🐶","🐣","🐕‍🦺","🐠","🐹","🐛","🐩","🐸"]
    
    private static func createMatchGame() -> MatchGame<String> {
        return MatchGame(numberOfPairsOfCards: emojis.count) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🥵"
            }
        }
    }
    
    @Published private var model = createMatchGame()
    
    var cards: Array<MatchGame<String>.Card> {
        return model.cards
    }
    
    
    // MARK: - Intents
    
    func choose(_ card: MatchGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func getEmojis() {
//        SetTheTheme()
    }
    
}
