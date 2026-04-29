//
//  ShoppingList.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI
import SwiftData

struct ShoppingList: View {
    
    @State var shoppingList:[ShoppingListItem] = [
        ShoppingListItem(ingredient: Ingredient(name: "Oignons"), quantity: 3),
        ShoppingListItem(ingredient: Ingredient(name: "Crème fraîche"), quantity: 1),
        ShoppingListItem(ingredient: Ingredient(name: "Jambon"), quantity: 8),
        ShoppingListItem(ingredient: Ingredient(name: "Pâte brisée"), quantity: 1),
    ]
    
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
                }
                .listStyle(.plain)
                
                HStack {
                    Button(role: .destructive) {
                        //TODO: Vider la liste de courses
                        deleteAllItems()
                    } label: {
                        Label("Vider la liste", systemImage: "trash")
                    }
                    
                    Button {
                        //TODO: Ajouter un élément à la liste de courses
                        addItem()
                    } label: {
                        Label("Ajouter", systemImage: "plus")
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
    
    func addItem() {
    }
    
    func deleteAllItems() {
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, ShoppingListItem.self, configurations: config)

    let egg = Ingredient(name: "Oeufs")
    let cream = Ingredient(name: "Crème fraîche")
    container.mainContext.insert(egg)
    container.mainContext.insert(cream)

    let items = [
        ShoppingListItem(ingredient: egg, quantity: 6),
        ShoppingListItem(ingredient: cream, quantity: 3)
    ]
    items.forEach { container.mainContext.insert($0) }

    return ShoppingList(shoppingList: items)
        .modelContainer(container)
}
