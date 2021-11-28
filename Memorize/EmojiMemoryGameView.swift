//
//  ContentView.swift
//  Memorize
//
//  Created by Victor Smirnov on 07.11.2021.
//

import SwiftUI

// App logic
struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
// <-- "New Game" button -->
            Button {
                game.newGame()
            } label: {
                Text("New Game")
                    .font(.largeTitle)
                    .padding(.horizontal)
            }
            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 3).foregroundColor(.red))
            .padding(.bottom)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .foregroundColor(game.gameThemeColor)
// <-- Theme and Score -->
            HStack {
                Text("Theme: '\(game.gameThemeName)'")
                Spacer()
                Text("Score: \(String(game.score))")
            }
         }
        .padding(.horizontal)
    }
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let startDegree = -90.0
                let endDegree = -315.0
                Pie(startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree))
                    .padding(DrawingConstants.piePadding)
                    .opacity(Double(DrawingConstants.pieOpacity))
                Text(card.content)
                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }

    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let piePadding: CGFloat = 6
        static let pieOpacity: CGFloat = 0.5
    }
}




// Preview Controller
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
