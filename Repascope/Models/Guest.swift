//
//  Item.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import Foundation
import SwiftData

@Model
final class Guest {
    var name: String
    var icon: String
    
    init(name: String, icon: String = "Unknown") {
        self.name = name
        self.icon = icon
    }
}
