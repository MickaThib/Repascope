//
//  ListableItem.swift
//  Repascope
//
//  Created by Mickael Thibouret on 04/05/2026.
//

import SwiftData

// Protocole commun
protocol ListableItem: AnyObject {
    var id: PersistentIdentifier { get }
    var displayName: String { get }
}

// Extensions sur vos modèles SwiftData
extension Ingredient: ListableItem {
    var displayName: String { name }
}

extension MealItem: ListableItem {
    var displayName: String { title }
}
