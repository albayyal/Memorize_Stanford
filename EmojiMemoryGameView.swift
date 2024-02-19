//
//  EmojiMemoryGameView.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 14.06.22.
//

import SwiftUI

// *** View ***
struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        // This View can be build with a ScrollView and a LazyVGrid combiner, but we want to see all cards without scrolling. Therefore we need to create a customer view combiner that kept all the cards the right size to fit them all on screen with a certain spect ratio
        // this is a custom VGrid we create for ourselves
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            gameBody
            shuffle
            .padding()
           
            HStack(spacing: 100){
                ThemeButton(themeType: "car.fill", themePosition: 0)
                ThemeButton(themeType: "display", themePosition: 1)
                ThemeButton(themeType: "pawprint.fill", themePosition: 2)
            }
        }
    }
    
    // to clean the code and make it easier to read we divide the view into smaller views
    var gameBody: some View {
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            // when we want to use function or closures in views we need to declare them as ViewBuilder-functions, so the compiler knows the closure is not a "normal" function. To declare the (last-) argument of the AspectVGrid function as a ViewBuilder-function we need to specify it in the Struct itself
            if card.isMatched && !card.isFaceUp {
                // to fill up the space of the card which was matched so it seems empty to the user we just set a color and set it to clear
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(.red)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            // adding the function ' withAnimation ' the shuffle looks much nicer
            withAnimation {
                game.shuffle()
            }
        }
    }
    
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngel: Angle(degrees: 0-90), endAngel: Angle(degrees: 120-90))
                    .padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    // font is not animatable so there will be some unexpected behavior for the animation to avoid this we can use a fixed size for the font so that the font size is not effecting the animation and use the .scaleEffect modifier to shrink the size down. scaleEffect is a geometry effect and it does not affect the animation
                    .font(font(in: geometry.size))
            }
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

struct ThemeButton: View {
    let themeType: String
    let themePosition: Int
    
    var body: some View {
        Button {
           
        } label: {
            Image(systemName: themeType)
        }
        .font(.largeTitle)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
