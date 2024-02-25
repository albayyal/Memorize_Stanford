//
//  EmojiMemoryGame.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 15.06.22.
//

import SwiftUI

// *** ViewModel ***
class EmojiMemoryGame: ObservableObject {
    //in a class alle properties(variables) needs to have a value. no property can be initialized without property
    
    // initialization of properties is random. To use a property during initialization inside another property we need to declare an init function and set the order or set the variable as global (declare outside the class). To declare the variable as global and keep it still inside the class we use the keyword static. with the keyword static we define the variable/constant/func as global so it does not need to be initialized inside the class. Static variable/constant/func (are called type variable attached) to the Struct/Class(Type) and exist once in our APP, while variable/constant/func without static are in every instance we create of the Struct/Class
    private static let transportEmojis = ["✈️", "🚀", "🚂", "🚁", "🚗", "🚢", "🚎", "🚛", "🏍", "⛵️", "🚘", "🚤", "🛺"]
    private static let gadgetEmojis = ["⌨️", "🖨", "☎️", "📱", "🖥", "💻", "🖱", "📺", "⏰", "📽", "🎥", "📷", "📻"]
    private static let animalEmojis = ["🦁", "🐥", "🐒", "🦉", "🦎", "🦂", "🐢", "🐞", "🐝", "🦆", "🦑", "🦀", "🐬"]
    
    @Published var cardEmojisPosition = 0
    
    @Published private var model = createMemoryGame()
    
    // use the function createMemoryGame to generate our model
    // as long as we cannot set the order for initialization of the methods and properties the function needs to be declared static (global) so it is initialized outside the Class for the hole APP
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            // if the number of the cards is out of the Emojis array a card will be created with the symbol "⁉️"
            if transportEmojis.indices.contains(pairIndex) {
                return transportEmojis[pairIndex]
            } else {
                return "⁉️"
            }
            
        }
    }
            
    // we used MemoryGame<String> several times, so to clean the code and make it easier we can set a substitute for it
    typealias Card = MemoryGame<String>.Card
    
    var cards: [Card] { model.cards }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func selectTheme(_ theme: String) {
        //model.selectTheme
    }
}
