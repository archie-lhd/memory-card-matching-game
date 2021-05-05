//
//  Int+RandomExcludingSome.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-04.
//

import Foundation
extension Int {
    static func random(in range: ClosedRange<Int>, excluding x: Int) -> Int {
        if range.contains(x) {
            let r = Int.random(in: Range(uncheckedBounds: (range.lowerBound, range.upperBound)))
            return r == x ? range.upperBound : r
        } else {
            return Int.random(in: range)
        }
    }
}
