//
//  EmojiMemoryGame.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-04-24.
//

import SwiftUI

// An Example of ViewModel
class EmojiMemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame<String>
    var theme: Theme
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: theme)
    }
   // @Published private var model: MemoryGame<String> = createMemoryGame(theme: ThemeManager.theme1)
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...theme.emojiSet.count)) { pairIndex in
            return theme.emojiSet[pairIndex]
        }
    }

    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent
    
    func choose(card: MemoryGame<String>.Card) {
        // objectWillChange.send()
        model.choose(card: card);
    }
    
    // MARK: - Reset the game by changing the model to a new one
    func resetGame(){//-> EmojiMemoryGameViewModel {
        model = EmojiMemoryGameViewModel.createMemoryGame(theme: theme)
        //return self
    }
    
    func getScore() -> Int {
        return model.getScore()
    }
}
