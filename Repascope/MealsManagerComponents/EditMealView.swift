//
//  EditMealView.swift
//  Repascope
//
//  Created by Mickael Thibouret on 05/05/2026.
//

import SwiftUI

struct EditMealView: View {
    
    @Binding var selectedMeal: MealItem?
    
    var body: some View {
        VStack {
            if let meal = selectedMeal {
                
                if let photo = meal.photo {
                    Image(photo)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                } else {
                    Image(systemName: "camera")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.white)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.3))
                }
                
                Text(meal.title)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading) {
                                        
                    Text("Ingrédients")
                        .font(.headline)
                    
                    RoundedRectangle(cornerRadius: 7)
                        .frame(height: 200)
                        .foregroundStyle(Color.gray.opacity(0.2))
                    
                    TextField("Notes", text: Binding(get: {meal.notes}, set: { selectedMeal?.notes = $0 }),axis: .vertical)
                        .lineLimit(5...10)
                        .padding(.vertical)
                }
                .frame(maxWidth: 500)
                
                Spacer()
                
            } else {
                //TODO: Ecran à terminer
                Text("Aucun repas sélectionné")
            }
        }
    }
}

#Preview {
    EditMealView(selectedMeal: .constant(MealItem(title: "Pâtes bolognaises", photo: nil, ingredients: [
        MealIngredient(ingredient: Ingredient(name: "Pâtes"), quantity: 1),
        MealIngredient(ingredient: Ingredient(name: "Sauce tomate"), quantity: 1),
        MealIngredient(ingredient: Ingredient(name: "Viande hâchée"), quantity: 1)
    ])))
    
    //EditMealView(selectedMeal: .constant(nil))
}
