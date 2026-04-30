//
//  ShoppingItem.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI
import SwiftData

struct ShoppingItem: View {
    
    let item: ShoppingListItem
    var deleteAction: (() -> Void)?
    @State var showDeleteAlert = false
    
    var body: some View {
        HStack {
            Image(systemName: item.isChecked ? "inset.filled.circle" : "circle")
                .font(.system(size: 18))
            Text(item.ingredient.name)
                .fontWeight(.bold)
            if item.quantity != 1 {
                Text("x \(item.quantity)")
            }
            
            Spacer()
            
            Button { item.quantity += 1 } label: { Image(systemName: "plus.circle") }
                .buttonStyle(.plain)
            Button {
                if item.quantity > 1 {
                    item.quantity -= 1
                } else {
                    showDeleteAlert = true
                }
            } label: { Image(systemName: "minus.circle") }
                .buttonStyle(.plain)
            
        }
        .opacity(item.isChecked ? 0.5 : 1)
        .onTapGesture {
            item.isChecked.toggle()
        }
        .alert("Supprimer \(item.ingredient.name) ?", isPresented: $showDeleteAlert) {
            Button("Supprimer", role: .destructive) { deleteAction?() }
            Button("Annuler", role: .cancel) {}
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ShoppingListItem.self, configurations: config)
    let ingredient = Ingredient(name: "Concombre")
    let item = ShoppingListItem(ingredient: ingredient, quantity: 1)
    return ShoppingItem(item: item, deleteAction: {})
        .modelContainer(container)
}
