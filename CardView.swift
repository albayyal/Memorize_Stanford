//
//  CardView.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 24.02.24.
//

import SwiftUI

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngel: Angle(degrees: 0-90), endAngel: Angle(degrees: 120-90))
                    .padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card)
                    // font is not animatable so there will be some unexpected behavior for the animation to avoid this we can use a fixed size for the font so that the font size is not effecting the animation and use the .scaleEffect modifier to shrink the size down. scaleEffect is a geometry effect and it does not affect the animation
                    .font(font(in: geometry.size))
            }
            // to use a custom modifier we build a struct and let it conform to AnimatableModifier protocol and with "extension View" we link our modifier (like all System SwiftUI ViewModifier) so it can be used to all Views
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // to shorten the code we set up a function for the font size
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    // it's always better to give names to constants so everybody knows the purpose of the constants
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circlePadding: CGFloat = 5
        static let circleOpacity: CGFloat = 0.5
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: EmojiMemoryGame.Card(isFaceUp: true, content: "X", id: "test2"))
            .padding()
        
    }
}
