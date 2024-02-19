//
//  Memorize_StanfordApp.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 14.06.22.
//

import SwiftUI

@main
struct Memorize_StanfordApp: App {
    // game is a pointer to the instance of the class EmojiMemoryGame
    // it is better to use private all the time only if you need access to it
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
