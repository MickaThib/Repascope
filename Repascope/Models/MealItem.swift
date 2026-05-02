//
//  MealItem.swift
//  Repascope
//
//  Created by Mickael on 01/05/2026.
//

import Foundation
import SwiftData

@Model
final class MealItem {
    var title: String
    var photo: String?
    @Relationship(deleteRule: .cascade) var ingredients: [MealIngredient]

    init(title: String, photo: String?, ingredients: [MealIngredient] = []) {
        self.title = title
        self.photo = photo
        self.ingredients = ingredients
    }
}
