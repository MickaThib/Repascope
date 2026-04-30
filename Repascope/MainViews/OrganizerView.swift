//
//  PlanningView.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI

struct OrganizerView: View {
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            //MARK: Contenu principal
            PlanningView()
            .frame(maxWidth: .infinity)
            
            //MARK: Volet droit
            VSplitView {
                
                //Section haute
                MealList()
                .frame(minHeight: 100) // hauteur minimale pour éviter l'écrasement
                                
                //Section basse
                ShoppingList()
                .frame(minHeight: 100) // hauteur minimale pour éviter l'écrasement
            }
            .padding()
            .frame(width: 280)
        }
    }
}

#Preview {
    OrganizerView()
}
