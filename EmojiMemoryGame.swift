//
//  EmojiMemoryGame.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 15.06.22.
//

import SwiftUI

// *** ViewModel ***
class EmojiMemoryGame: ObservableObject {
    // we used MemoryGame<String> several times, so to clean the code and make it easier we can set a substitute for it
    typealias Card = MemoryGame<String>.Card
    
    // initialisation of properties is random. To use a property during initialisation inside another property we need to declare an init function and set the order or set the variable as global (declare outside the class). To declare the variable as global and keep it still inside the class we use the keyword static. with the keyword static we define the variable/constant/func as global so it does not need to be initialized inside the class. Static variable/constant/func attached to the Struct/Class(Type) and exist once in our APP, while variable/constant/func without static are in every instance we create of the Struct/Class
    private static let transportEmojis = ["✈️", "🚀", "🚂", "🚁", "🚗", "🚢", "🚎", "🚛", "🏍", "⛵️", "🚘", "🚤", "🛺"]
    private static let gadgetEmojis = ["⌨️", "🖨", "☎️", "📱", "🖥", "💻", "🖱", "📺", "⏰", "📽", "🎥", "📷", "📻"]
    private static let animalEmojis = ["🦁", "🐥", "🐒", "🦉", "🦎", "🦂", "🐢", "🐞", "🐝", "🦆", "🦑", "🦀", "🐬"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            transportEmojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [Card] { model.cards }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}

//struct Previews_EmojiMemoryGame_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
