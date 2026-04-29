//
//  ShoppingListItem.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import Foundation
import SwiftData

@Model
final class ShoppingListItem {
    var ingredient: Ingredient
    var quantity: Int

    init(ingredient: Ingredient, quantity: Int) {
        self.ingredient = ingredient
        self.quantity = quantity
    }
}
