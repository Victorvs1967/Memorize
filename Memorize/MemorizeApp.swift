//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Victor Smirnov on 07.11.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
