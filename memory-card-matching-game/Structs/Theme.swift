//
//  Theme.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-05.
//

import Foundation
import SwiftUI

struct Theme: Identifiable {
    var themeName: String
    var accentColor: Color
    var emojiSet: Array<String>
    var id: Int
    
    static let theme1 = Theme (
        themeName: "Fruits on farm",
        accentColor: .pink,
        emojiSet: ["🍎", "🍊", "🍋", "🍌", "🍉", "🍇"],
        id: 1
    )
    
    static let theme2 = Theme (
        themeName: "Animals in Zoo",
        accentColor: .orange,
        emojiSet: ["🦊", "🐻", "🐼", "🐨", "🐯", "🦁"],
        id: 2
    )
    
    static let theme3 = Theme (
        themeName: "Balls on Playground",
        accentColor: .yellow,
        emojiSet: ["⚽️", "🏀", "🏈", "🎾", "🏐", "🎱"],
        id: 3
    )
    
    
    static let theme4 = Theme (
        themeName: "Vegetables on Farm",
        accentColor: .green,
        emojiSet: ["🥦","🥬","🥒","🫑","🌽","🍆"],
        id: 4
    )
    
    static let theme5 = Theme (
        themeName: "Countries in World",
        accentColor: .blue,
        emojiSet: ["🇨🇦", "🇺🇸", "🇨🇳", "🇫🇷", "🇷🇺", "🇬🇧"],
        id: 5
    )
    
    static let theme6 = Theme (
        themeName: "Vehicles on Road",
        accentColor: .purple,
        emojiSet: ["🚎","🛵","🚕","🚓","🚑","🚚","🚒"],
        id: 6
    )
}

class ThemeSet: ObservableObject {
    @Published var themeSet: Array<Theme> = [Theme.theme1, Theme.theme2, Theme.theme3, Theme.theme4, Theme.theme5, Theme.theme6]

//    func addTheme(theme: Theme) {
//        themeSet.
//    }
    func addTheme(name: String, accentColor: Color, emojiSet: Array<String>) {
        themeSet.append(Theme(themeName: name,
                                   accentColor: accentColor,
                                   emojiSet: emojiSet,
                                   id: themeSet.count + 1))
    }
    func getThemeSet() -> Array<Theme> {
        return self.themeSet
    }
}
