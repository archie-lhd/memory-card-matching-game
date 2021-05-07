//
//  MemoryGame.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-04-24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set {
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
            }
        }
        
    }

    mutating func choose(card: Card) { // "mutating" means the function can modify the struct itself
        
        // print("card chosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    changeScore(to: score + MATCH_POINT_CHANGE + Int(Double(MAX_BONUS_POINT) * min(cards[chosenIndex].bonusRemaining, cards[potentialMatchIndex].bonusRemaining)))
                } else if cards[chosenIndex].bonusRemaining < 1 {
                    changeScore(to: score + MISMATCH_POINT_CHANGE)
                }
                
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    // "implicitly" mutating itself
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        score = 0
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle()
    }
    
    // MARK: - Implementing score
    func getScore() -> Int {
        return score
    }
    
    mutating func changeScore(to newScore: Int) {
        score = newScore
    }
    
    
    struct Card: Identifiable { // Identifiable is a protocol
        
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent // "don't care"-type, generics
        var id: Int
        
        
        
        
        
        
        
        var bonusTimeLimit: TimeInterval = 3
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
    
    // MARK: - Constants
    
    let MATCH_POINT_CHANGE = 10
    let MISMATCH_POINT_CHANGE = -5
    let MAX_BONUS_POINT = 6
    
}
