//
//  Ingredient.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import Foundation
import SwiftData

@Model
final class Ingredient: Hashable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
