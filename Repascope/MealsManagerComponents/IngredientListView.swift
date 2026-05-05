//
//  IngredientList.swift
//  Repascope
//
//  Created by Mickael on 04/05/2026.
//

import SwiftUI
import SwiftData

struct IngredientListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Ingredient.name) private var ingredients: [Ingredient]
    
    @State var showDeleteAlert:Bool = false
    @State private var ingredientToDelete:Ingredient?
    
    @State var showAddIngredientSheet:Bool = false
    @State var ingredientToAdd: String = ""
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(alignment: .lastTextBaseline) {
                
                Text("Ingrédients")
                    .font(.largeTitle)
                    .padding(.top)
                    .padding(.horizontal)
                
                Spacer()
                
                Button {
                    showAddIngredientSheet = true
                } label: {
                    Label("Ajouter", systemImage: "plus")
                }
                .padding(.trailing)
                .buttonStyle(.borderless)
            }
            .padding(.horizontal)
            .padding(.top)
            
            //TODO: Recherche
            TextField("Rechercher", text: .constant(""))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .padding(.vertical)
            
            List(ingredients, id: \.id) { ingredient in
                CustomLabel(
                    title: ingredient.name,
                    type: .ingredient,
                    isSelected: false,
                    deleteAction: {deleteIngredient(ingredient: ingredient)}
                )
                .listRowSeparator(.hidden)
                .frame(height: 30)
                .draggable(IngredientTransfer(persistentID: ingredient.persistentModelID))
            }
            .padding(.top, 0)
        }
        .alert("Supprimer \(ingredientToDelete?.name ?? "cet ingrédient") ?", isPresented: $showDeleteAlert) {
            Button("Annuler", role: .cancel) {
                ingredientToDelete = nil
            }
            Button("Supprimer", role: .destructive) {
                if let ingredient = ingredientToDelete {
                    modelContext.delete(ingredient)
                    try? modelContext.save()
                    ingredientToDelete = nil
                }
            }
        }
        .sheet(isPresented: $showAddIngredientSheet, onDismiss: {
            ingredientToAdd = ""
        }) {
            VStack(spacing: 16) {
                Text("Ajouter un ingrédient")
                    .font(.headline)
                TextField("Nom de l'ingrédient", text: $ingredientToAdd)
                    .frame(width: 300)
                HStack {
                    Button("Annuler", role: .cancel) {
                        ingredientToAdd = ""
                        showAddIngredientSheet = false
                    }
                    Button("Ajouter") {
                        //TODO: Rendre ce bouton valide avec la touche entrée
                        addIngredient(name: ingredientToAdd)
                        ingredientToAdd = ""
                        showAddIngredientSheet = false
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(ingredientToAdd.isEmpty)
                }
            }
            .padding()
        }
    }
    
    func addIngredient(name: String) {
        modelContext.insert(Ingredient(name: name))
        try? modelContext.save()
    }
    
    func deleteIngredient(ingredient:Ingredient) {
        ingredientToDelete = ingredient
        showDeleteAlert = true
    }
}

#Preview {
    IngredientListView()
}
