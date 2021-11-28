//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Victor Smirnov on 11.11.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card

    private static let themes = [
        Theme(id: 1,
            name: "transport",
            emojiSet: ["✈️", "🚀", "🚁", "🚂", "🚗", "🚕", "🚙", "🚎", "🚌", "🚑", "🚓", "🚒", "🚜", "⛵️", "🚛", "🚤", "🛸", "🛻", "🚃", "🚟"],
            numberOfPairs: 10),
       Theme(id: 2,
            name: "food",
            emojiSet: ["🥐", "🥯", "🍞", "🥖", "🥨", "🧀", "🥚", "🍳", "🧈", "🥞", "🧇", "🥓", "🥩", "🍗", "🍖", "🌭", "🍔", "🍟", "🍕", "🫓"],
            numberOfPairs: 10,
            color: "green"),
       Theme(id: 3,
            name: "faces",
            emojiSet: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈", "🙉", "🙊"],
            numberOfPairs: 8,
              color: "yellow"),
       Theme(id: 4,
            name: "halloween",
            emojiSet: ["😈", "👹", "👺", "🤡", "💩", "👻", "💀", "☠️", "👽", "👾", "🤖", "🎃", "🕷", "🧛‍♂️", "🧙", "🧟‍♂️", "🦄"],
            numberOfPairs: 6,
            color: "orange")
    ]

    struct Theme: Identifiable {
        let id: Int
        let name: String
        let emojiSet: Array<String>
        let numberOfPairs: Int
        var color: String = "red"
    }

    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        let numberOfPairs = theme.numberOfPairs < theme.emojiSet.count ? theme.numberOfPairs : theme.emojiSet.count
        let emojiSet = theme.emojiSet.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojiSet[pairIndex]
        }
    }
    
    private var gameTheme: Theme
    
    @Published private var model: MemoryGame<String>
    
    init() {
        gameTheme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
        model = EmojiMemoryGame.createMemoryGame(gameTheme)
    }
        
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var gameThemeName: String {
        gameTheme.name
    }
    
    var gameThemeColor: Color {
        switch gameTheme.color {
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "green":
            return .green
        case "indigo":
            return .pink
        default:
            return .red
        }
    }
    
    func newGame() {
        gameTheme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
        model = EmojiMemoryGame.createMemoryGame(gameTheme)
    }
        
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
}
