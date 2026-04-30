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
    var date: Date
    var isChecked: Bool = false

    init(ingredient: Ingredient, quantity: Int, date: Date = Date()) {
        self.ingredient = ingredient
        self.quantity = quantity
        self.date = date
    }
}
