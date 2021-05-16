//
//  ThemeCollectionManager.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-07.
//

import SwiftUI

class ThemeCollectionManager: ObservableObject {
    
    @Published private var themeCollection: ThemeCollection {
        didSet {
            UserDefaults.standard.set(themeCollection.json, forKey: "theme-collection")
        }
    }
    init() {
        themeCollection = ThemeCollection(json: UserDefaults.standard.data(forKey: "theme-collection")) ?? ThemeCollection()
    }
    
    var themes: [ThemeCollection.Theme] { themeCollection.themes }
    
    
    // MARK: - Intents
    func addTheme(name: String, accentColor: UIColor, emojiSet: [String]) {
        themeCollection.addTheme(name: name, accentColor: accentColor, emojiSet: emojiSet)
    }
    func moveTheme(fromOffsets: IndexSet, toOffset: Int) {
        themeCollection.moveTheme(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    func editTheme(id: UUID, name: String, accentColor: UIColor, emojiSet: [String]) {
        themeCollection.editTheme(id: id, name: name, accentColor: accentColor, emojiSet: emojiSet)
    }
    func resetThemes() {
        themeCollection.resetThemes()
    }
    func removeTheme(atOffsets: IndexSet) {
        themeCollection.removeTheme(atOffsets: atOffsets)
    }
    
}
