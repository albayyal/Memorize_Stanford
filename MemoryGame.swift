//
//  MemoryGame.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 15.06.22.
//

import Foundation

// *** Model ***
// when we use a ("do not care") generic type we have to declare it in the struct <...>
// using the keyword "where" and match the generic typ to the Equatable protocol we can compare the value of the generic variable
struct MemoryGame <CardContent> where CardContent: Equatable {
    
        private(set) var cards: [Card]
        
        private var indexOfTheOneAndOnlyFaceUpCard: Int? {
            // with get and set you can choose what kind of value a computed variable can have
            get {
                // we filter all Indices of the cards which are faceUp with the function filter, the function filter returns an array containing, in order, the elements of the sequence that satisfy the given predicate
                // the extension below we have used to add the variable "oneAndOnly" to all Arrays
                cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
            }
            set {
                // we cannot choose the variables name inside it's own calculation therefore the function "set" gives the opportunity to use the keyword newValue
                // this is a short term of a "for" loop and if condition, if the card is faceUp
                // cards[$0].isFaceUp = ($0 == newValue) we are saying isFaceUp is only true if $0 equals the newValue
                cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)}
            }
        }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // we can only use " == " to compare the generic content because we link the struct to the "Equatable" protocol at the beginning
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle () {
        cards.shuffle()
    }
    
    // the init function have two arguments. the first with type Int and the second with another function as type and returns CardContent
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards to card array
        for pairIndex in 0..<numberOfPairsOfCards {
            // createCardContent is a function takes an Int as argument and return a CardContent
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        // we do not care what type the variable "content" has, it needs to be set up when creating an instance of the Struct MemoryGame, when we use a ("do not care") generic type we have to declare it in the struct <...>
        let content: CardContent
        let id: Int
    }
}

// with extension we can add function and variables to an existing struct without having access to the struct itself, however we can add only computed variables with extension. here we add the computed variable "oneAndOnly" to the Array-struct, so all array can use this variable now
// the type "Element" is the don't care of the struct Array, which is in the system. press documentation on the array for description
// we can even remove the keyword "self"
extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
