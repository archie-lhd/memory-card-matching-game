//
//  ThemeCollection.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-07.
//

import SwiftUI

struct ThemeCollection: Codable {
    var themes = [Theme]()
    
    struct Theme: Identifiable, Codable {
        var name: String
        var accentColor: UIColor.RGB
        var emojiSet: [String]
        var id: Int
        
        init(name: String, accentColor: UIColor, emojiSet: [String], id: Int) {
            self.name = name
            self.accentColor = accentColor.rgb
            self.emojiSet = emojiSet
            self.id = id
        }
    }
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) { // failable
        if json != nil, let newThemeCollection = try? JSONDecoder().decode(ThemeCollection.self, from: json!) {
            self = newThemeCollection
        } else {
            return nil
        }
    }
    
    init() {
        self.themes = [DefaultThemes.theme0, DefaultThemes.theme1, DefaultThemes.theme2, DefaultThemes.theme3, DefaultThemes.theme4, DefaultThemes.theme5]
    }
    
    mutating func addTheme(name: String, accentColor: UIColor, emojiSet: [String]) {
        themes.append(Theme(name: name, accentColor: accentColor, emojiSet: emojiSet, id: themes.count))
        
    }
    
    mutating func editTheme(id: Int, name: String, accentColor: UIColor, emojiSet: [String]) {
        themes[id].name = name
        themes[id].accentColor = accentColor.rgb
        themes[id].emojiSet = emojiSet
    }
    
    mutating func removeTheme(atOffsets: IndexSet) {
        themes.remove(atOffsets: atOffsets)
        
    }
}
