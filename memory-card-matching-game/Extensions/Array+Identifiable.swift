//
//  Array+Identifiable.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-04-29.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {    // return value is an Optional
        for index in 0 ..< self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
