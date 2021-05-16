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
        var id = UUID()//.uuidString
        
        init(name: String, accentColor: UIColor, emojiSet: [String]) {
            self.name = name
            self.accentColor = accentColor.rgb
            self.emojiSet = emojiSet
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
        themes.append(Theme(name: name, accentColor: accentColor, emojiSet: emojiSet))
    }
    mutating func moveTheme(fromOffsets: IndexSet, toOffset: Int) {
        themes.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    mutating func editTheme(id: UUID, name: String, accentColor: UIColor, emojiSet: [String]) {
        for index in themes.indices {
            if themes[index].id == id {
                themes[index].name = name
                themes[index].accentColor = accentColor.rgb
                themes[index].emojiSet = emojiSet
            }
        }
    }
    mutating func resetThemes() {
        self.themes = [DefaultThemes.theme0, DefaultThemes.theme1, DefaultThemes.theme2, DefaultThemes.theme3, DefaultThemes.theme4, DefaultThemes.theme5]
    }
    mutating func removeTheme(atOffsets: IndexSet) {
        themes.remove(atOffsets: atOffsets)
        
    }
}
