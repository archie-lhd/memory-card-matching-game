//
//  Cardify.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-01.
//

import SwiftUI

struct Cardify: AnimatableModifier { // == (ViewModifier, Animatable)
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: CORNER_RADIUS)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: CORNER_RADIUS)
                    .stroke(lineWidth: 3)

                content
            }.opacity(isFaceUp ? 1.0 : 0.0)
            RoundedRectangle(cornerRadius: CORNER_RADIUS)
                .opacity(isFaceUp ? 0.0 : 1.0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0)) // around Z-axis
    }
    private let CORNER_RADIUS: CGFloat = 10.0
    private let EDGE_LINE_WIDTH: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
