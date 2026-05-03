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
    
    var body: some View {
        VStack {
            HSplitView {
                
                VStack {
                    
                    HStack {
                        Text("Ingrédients")
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                        //TODO: Recherche
                        TextField("Rechercher", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 150)
                        Button {
                            //TODO: Ajouter un ingrédient
                        } label: {
                            Label("Ajouter", systemImage: "plus")
                        }
                        .padding()
                        .buttonStyle(.borderless)
                    }
                    .padding(.horizontal)
                    
                    
                    List(ingredients) { ingredient in
                        CustomLabel(title: ingredient.name, type: .ingredient)
                            .listRowSeparator(.hidden)
                            .frame(height: 30)
                    }
                    
                    Divider()
                }
                
                VStack(spacing:0) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("Plats")
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                        //TODO: Recherche
                        TextField("Rechercher", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 150)
                        Button {
                            //TODO: Ajouter un ingrédient
                        } label: {
                            Label("Ajouter", systemImage: "plus")
                        }
                        .padding()
                        .buttonStyle(.borderless)
                    }
                    .padding(.horizontal)
                    
                    List(meals) { meal in
                        CustomLabel(title: meal.title, type: .meal)
                            .listRowSeparator(.hidden)
                            .frame(height: 30)
                    }
                    
                    Divider()
                }
                .frame(maxWidth: .infinity)
                
            }
            .frame(height: 250)
            .frame(maxWidth: .infinity)
            
            VStack {
                Text("Formulaire")
            }
            .frame(maxHeight: .infinity)
        }
        .toolbar {
            Button("Données de test") {
                addDataTest()
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
