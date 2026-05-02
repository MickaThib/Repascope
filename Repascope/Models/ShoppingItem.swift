//
//  ShoppingListItem.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import Foundation
import SwiftData

@Model
final class ShoppingItem {
    var name: String = ""
    var quantity: Int
    var date: Date
    var isChecked: Bool = false

    init(name: String, quantity: Int, date: Date = Date()) {
        self.name = name
        self.quantity = quantity
        self.date = date
    }
}
