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
            HStack{
                Text("Score: \(game.score)")
                    .animation(nil)
                Spacer()
                shuffle
            }
            .padding()
            
            HStack(spacing: 100) {
                ForEach (["car.fill", "display", "pawprint.fill"], id: \.self) { theme in
                    Button {
                        game.selectTheme(theme)
                    } label: {
                        Image(systemName: theme)
                    }
                    .font(.title)
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
