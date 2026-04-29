//
//  ShoppingList.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI
import SwiftData

struct ShoppingList: View {
    
    @State private var shoppingList:[ShoppingListItem] = [
        ShoppingListItem(ingredient: Ingredient(name: "Oignons"), quantity: 3),
        ShoppingListItem(ingredient: Ingredient(name: "Crème fraîche"), quantity: 1),
        ShoppingListItem(ingredient: Ingredient(name: "Jambon"), quantity: 8),
        ShoppingListItem(ingredient: Ingredient(name: "Pâte brisée"), quantity: 1),
    ]
    @State private var isAddingItem: Bool = false
    @State private var newItemName: String = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("Liste de courses")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.vertical, 10)
            Divider()
            
            Group {
                List {
                    ForEach(shoppingList, id: \.self) { item in
                        ShoppingItem(item: item.ingredient.name, quantity: item.quantity)
                            .listRowSeparator(.hidden)
                    }
                    
                    if isAddingItem {
                        HStack {
                            Image(systemName: "circle")
                                .font(.system(size: 18))
                            TextField("Nouvel élément", text: $newItemName)
                                .focused($isInputFocused)
                                .onSubmit { confirmNewItem() }
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                
                HStack {
                    Button(role: .destructive) {
                        //TODO: Vider la liste de courses
                        deleteAllItems()
                    } label: {
                        Label("Vider la liste", systemImage: "trash")
                    }
                    
                    Button(action: startAddingItem) {
                        if isAddingItem {
                            Label("Terminer", systemImage: "xmark")
                        } else {
                            Label("Ajouter", systemImage: "plus")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .background(Color.white)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.pink.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.pink.opacity(0.3), lineWidth: 3)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top)
    }
    
    func startAddingItem() {
        if isAddingItem == false {
            newItemName = ""
            isAddingItem = true
            isInputFocused = true
        } else {
            isAddingItem = false
        }
    }
    
    func confirmNewItem() {
        let name = newItemName.trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty else {
            isAddingItem = false
            return
        }
        let ingredient = Ingredient(name: name)
        shoppingList.append(ShoppingListItem(ingredient: ingredient, quantity: 1))
        newItemName = ""
        // reste en mode saisie pour enchaîner les ajouts
        isInputFocused = true
    }
    
    func deleteAllItems() {
        shoppingList.removeAll()
    }
}

#Preview {
    ShoppingList()
}
