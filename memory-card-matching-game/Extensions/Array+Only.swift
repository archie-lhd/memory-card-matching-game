//
//  Array+Only.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-04-30.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
