//
//  MatchGameModel.swift
//  MatchGame
//
//  Created by Jesse Decker on 8/26/23.
//

import Foundation


struct MatchGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content,id:"\(pairIndex+1)a"))
            cards.append(Card(content: content,id:"\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    
    
    mutating func shuffle() {
        cards.shuffle()
//        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up": "down") \(isMatched ? "matched":"unmatched")"
        }
        
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: String
    }
    
    var keyCardIndex: Int? {
        get {cards.indices.filter { index in cards[index].isFaceUp}.only}
        set {cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = keyCardIndex{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    keyCardIndex = nil
                } else {
                    for index in cards.indices {
                        cards[index].isFaceUp = false
                    }
                    keyCardIndex = chosenIndex
                }
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
