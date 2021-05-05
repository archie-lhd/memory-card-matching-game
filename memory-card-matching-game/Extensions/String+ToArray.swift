//
//  String+ToArray.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-05.
//

import Foundation

extension String {
    func splitIntoArrayOfString() -> Array<String> {
        let charArr: Array<Character> = Array(self)
        var strArr: Array<String> = []
        for char in charArr {
            strArr.append(String(char))
        }
        return strArr
    }
}
