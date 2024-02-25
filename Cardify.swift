//
//  Cardify.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 03.07.22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    // here we are creating our own ViewModifier to create Cards. As like all other ViewModifier it is a struct which confirms the ViewModifier protocol. A ViewModifier takes any kind of View as a generic Argument, modify it and returns a new View.
    // Because we want it to be animated we use the 'AnimatableModifier' protocol which itself confirm to the protocols 'Animatable'and 'ViewModifier'
    
    // to implement a 3D rotation animation when selecting a card we need a variable to track down the rotation angle and based on that we show the back or the front of the card, but as the AnimatableModifier protocol require a variable called 'animatableData' we try to rename the variable to make the code more readable and clear
    // we declare a calculated variable which will run from a start value and run with steps to an end value and set each time the new value to the variable rotation 
    var animatableData: Double {
        get{ rotation }
        set{ rotation = newValue }
    }
    var rotation: Double // in degrees
    
    // the model need to track the status of the card isFaceUp or not for the animation we need to track the rotation angle
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // the View Protocol require a variable body, but the ViewModifier require a function body with a generic as argument
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                base.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .background(base.fill(.white))
            } else {
                base.fill()
            }
            // here we modify any content which is passed to this struct
            // to use animation the content has to be from start on the screen therefore it is outside the if-condition so it is always on screen, to hide it from the user we used the modifier .opacity and set up the short hand if statement
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    // it's always better to give names to constants so everybody knows the purpose of the constants
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let circlePadding: CGFloat = 5
        static let circleOpacity: CGFloat = 0.5
    }
}

// with the struct on top we generate our own modifier this way ".modifier(Cardify(isFaceUp: card.isFaceUp))" on any View
// to simple the code for calling our modifier (like all System SwiftUI ViewModifier) we add an extension so it can be used to any View
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
