//
//  AspectVGrid.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 01.07.22.
//

import SwiftUI

// here we create the custom AspectVGrid that we want with two Generic arguments we do not care but at least they should conform to Identifiable and View protocol -> it's the same when we define "struct MemoryGame <CardContent> where CardContent: Equatable" here we have a Generic typ of CardContent that should conform to "Equatable" protocol
struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    // first we need to declare the arguments for the View combiner we have used in our View "EmojiMemoryGameView"
    // the type of the variable item is an array of generic types, we do not care what type it is so we create a new type for it. the type needs to be set during declaration
    var items: [Item]
    var aspectRatio: CGFloat
    // the content is as we declared in our View "EmojiMemoryGameView" a function that takes the parameter "cards" and returns a View. The return View is also a Generic type because we do not care, but it has to be at least a view therefore we used the keyword "where" to set it at to confirm the view protocol
    var content: (Item) -> ItemView
    
    // we need to declare an init function to declare the content variable/function as a ViewBuilder-function
    // init function takes a function as an argument, but the result of the function is saved outside the scope of init therefore we used the keyword @escape to save and use the result outside of the init scope
    // the AspectVGrid confirms to the View protocol, so it should return a View, if we want to use functions inside the View (like in the struct "EmojiMemoryGameView" than we need to declare it as @ViewBuilder
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        // the GeometryReader is a flexible container and takes all the space wich is possible and it is a good habit to make the views inside the GeometryReader also flexible, thats why we set VStack and a spacer inside the geometry reader.
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                // the vertical spacing we can set as an argument for the LazyVGrid, but for the horizontal spacing we set up the function "adaptiveGridItem" to set up the spacing to 0
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    // in a ForEach loop all the items needs to be uniquely identifiable, as long as the item is a generic type where we do not care what type it is, we use at the top again the keyword to let the generic type at least confirms the identifiable protocol
                    ForEach (items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    // here we calculate the width of the cards according the space it is given to us, so that all cards are shown on display. this calculation is set for the case that there is no space between the cards. Otherwise the calculation is more complex
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
