//
//  MemoryGame.swift
//  Memorize
//
//  Created by Victor Smirnov on 11.11.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }}
    }
    
    private var alreadyBeenSeen: Array<Int>
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenIndex].isFaceUp,
           !cards[choosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[choosenIndex].content == cards[potentialMatchIndex].content { // cards matched
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                cards[choosenIndex].isFaceUp = true
            } else { // cards not matched
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
                if alreadyBeenSeen.contains(cards[choosenIndex].id) {
                    score -= 1
                }
                alreadyBeenSeen.append(card.id)
            }
        }
    }
        
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        score = 0
        cards = []
        alreadyBeenSeen = Array<Int>()
        // add numbersOfPairsOfCards x 2 cards to cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
            cards.shuffle()
        }
    }
    
    struct Card: Identifiable {
        let id: Int
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
    }
}

extension Array {
    var oneAndOnly: Element? {
       self.count == 1 ? self.first : nil
    }
}
