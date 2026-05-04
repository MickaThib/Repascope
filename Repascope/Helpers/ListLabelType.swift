//
//  Untitled.swift
//  Repascope
//
//  Created by Mickael Thibouret on 04/05/2026.
//
import SwiftUI

enum ListLabelType: String {
    case ingredient = "Ingrédients"
    case meal = "Plats"
    
    func ItemColor() -> Color {
        switch self {
        case .ingredient:
            return Color.green
        case .meal:
            return Color.blue
        }
    }
}
