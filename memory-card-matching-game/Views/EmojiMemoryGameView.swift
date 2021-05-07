//
//  EmojiMemoryGameView.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-04-23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        return VStack{
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
            }
                .padding()
            .foregroundColor(Color(viewModel.theme.accentColor))
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            }, label: {
                Text("New Game")
                    .font(.headline)
            })
        }
        .navigationTitle(viewModel.theme.name)
        .navigationBarItems(trailing:Group{Text("Score: \(viewModel.getScore())")})
        .accentColor(Color(viewModel.theme.accentColor))
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: Angle.degrees(0-90),
                            endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90),
                            clockwise: true
                        ).onAppear{
                            self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(
                            startAngle: Angle.degrees(0-90),
                            endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90),
                            clockwise: true
                        )
                    }
                }.padding(5).opacity(0.25).transition(.identity)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)

        }
    }
    // MARK: - drawing constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel(theme: DefaultThemes.theme1)
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
