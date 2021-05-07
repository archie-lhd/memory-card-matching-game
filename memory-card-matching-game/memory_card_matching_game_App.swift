//
//  memory_card_matching_game_App.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-04-23.
//

import SwiftUI

@main
struct memory_card_matching_game_App: App {
    var body: some Scene {
        WindowGroup {
            ThemeSelectionView(tcManager: ThemeCollectionManager())
        }
    }
}
