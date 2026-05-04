//
//  MealsManager.swift
//  Repascope
//
//  Created by Mickael on 02/05/2026.
//

import SwiftUI
import SwiftData

struct MealsManager: View {
    
    @Environment(\.modelContext) private var modelContext

    @Query private var ingredients: [Ingredient]
    @Query private var meals: [MealItem]
    
    @State var selectedItem: ListableItem? = nil
    
    var body: some View {
        VSplitView {
            
            HSplitView {
                MealsManagerList(items: ingredients, type: .ingredient, selectedItem: $selectedItem)
                MealsManagerList(items: meals, type: .meal, selectedItem: $selectedItem)
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Text("Formulaire")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .toolbar {
            Button("Données de test") {
                addDataTest()
            }
        }
        .onChange(of: meals) {
            if selectedItem == nil, let first = meals.first {
                selectedItem = first
            }
        }
    }
    
    
    func addDataTest() {
        let ingredientsDataTest = [
            Ingredient(name: "Carotte"),
            Ingredient(name: "Pommes de terre"),
            Ingredient(name: "Pain de mie"),
            Ingredient(name: "Avocats")
        ]
        
        let mealsDataTest = [
            MealItem(title: "Raclette", photo: nil, ingredients: []),
            MealItem(title: "Hamburger maison", photo: nil, ingredients: []),
            MealItem(title: "Hot dogs", photo: nil, ingredients: []),
            MealItem(title: "Poisson pané", photo: nil, ingredients: []),
            MealItem(title: "Quiche lorraine", photo: nil, ingredients: []),
            MealItem(title: "Lasagnes", photo: nil, ingredients: [])
        ]
        
        for ingredient in ingredientsDataTest {
            modelContext.insert(ingredient)
            try? modelContext.save()
        }
        
        for meal in mealsDataTest {
            modelContext.insert(meal)
            try? modelContext.save()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, MealItem.self, configurations: config)
    
    let ingredients = [
        Ingredient(name: "Carotte"),
        Ingredient(name: "Pommes de terre"),
        Ingredient(name: "Pain de mie"),
        Ingredient(name: "Avocats")
    ]
    
    let meals = [
        MealItem(title: "Raclette", photo: nil, ingredients: []),
        MealItem(title: "Hamburger maison", photo: nil, ingredients: []),
        MealItem(title: "Hot dogs", photo: nil, ingredients: []),
        MealItem(title: "Poisson pané", photo: nil, ingredients: []),
        MealItem(title: "Quiche lorraine", photo: nil, ingredients: []),
        MealItem(title: "Lasagnes", photo: nil, ingredients: [])
    ]
    
    for ingredient in ingredients { container.mainContext.insert(ingredient) }
    for meal in meals { container.mainContext.insert(meal) }
    
    return MealsManager()
        .modelContainer(container)
}
