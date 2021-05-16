//
//  DefaultThemes.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-07.
//

import SwiftUI

struct DefaultThemes {

    static let theme0 = ThemeCollection.Theme (
        name: "Fruits in Basket",
        accentColor: UIColor(Color.pink),
        emojiSet: ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇"]
    )
    
    static let theme1 = ThemeCollection.Theme (
        name: "Animals in Zoo",
        accentColor: UIColor(Color.orange),
        emojiSet: ["🦊", "🐻", "🐼", "🐨", "🐯", "🦁"]
    )
    
    static let theme2 = ThemeCollection.Theme (
        name: "Balls on Playground",
        accentColor: UIColor(Color.yellow),
        emojiSet: ["⚽️", "🏀", "🏈", "🎾", "🏐", "🎱"]
    )
    
    
    static let theme3 = ThemeCollection.Theme (
        name: "Vegetables on Farm",
        accentColor: UIColor(Color.green),
        emojiSet: ["🥦","🥬","🥒","🫑","🌽","🍆"]
    )
    
    static let theme4 = ThemeCollection.Theme (
        name: "Countries in World",
        accentColor: UIColor(Color.blue),
        emojiSet: ["🇨🇦", "🇺🇸", "🇨🇳", "🇫🇷", "🇷🇺", "🇬🇧"]
    )
    
    static let theme5 = ThemeCollection.Theme (
        name: "Vehicles on Road",
        accentColor: UIColor(Color.purple),
        emojiSet: ["🚎","🛵","🚕","🚓","🚑","🚚","🚒"]
    )
}
