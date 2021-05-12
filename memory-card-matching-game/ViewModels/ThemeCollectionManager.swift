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
    func editTheme(id: Int, name: String, accentColor: UIColor, emojiSet: [String]) {
        themeCollection.editTheme(id: id, name: name, accentColor: accentColor, emojiSet: emojiSet)
    }
    func removeTheme(atOffsets: IndexSet) {
        themeCollection.removeTheme(atOffsets: atOffsets)
    }
    
}
