//
//  ShoppingList.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI
import SwiftData

struct ShoppingList: View {
    
    let date:Date
    
    @Environment(\.modelContext) private var modelContext
    
    // Calcule le début et la fin du jour
    private var startOfDay: Date {
        Calendar.current.startOfDay(for: date)
    }
    private var endOfDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
    }
    
    @Query private var shoppingList:[ShoppingItem]
    
    private var sortedList: [ShoppingItem] {
        shoppingList.sorted { !$0.isChecked && $1.isChecked }
    }
    
    @State private var isAddingItem: Bool = false
    @State private var newItemName: String = ""
    @FocusState private var isInputFocused: Bool
    @State private var showEmptyListAlert: Bool = false
    
    init(date:Date) {
        self.date = date
        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        
        _shoppingList = Query(
            filter: #Predicate<ShoppingItem> { item in
                item.date >= start && item.date < end
            }
        )
    }
    
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
                    ForEach(sortedList, id: \.self) { item in
                        ShoppingListItem(item: item, deleteAction: { delete(item: item) })
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
                        showEmptyListAlert = true
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
        .alert("Vider la liste ?", isPresented: $showEmptyListAlert) {
            Button("Vider la liste", role: .destructive) {
                deleteAllItems()
            }
            Button("Annuler", role: .cancel) {}
        }
    }
    
    func startAddingItem() {
        if isAddingItem == false {
            newItemName = ""
            isAddingItem = true
            isInputFocused = true
        } else {
            // Action "Terminer"
            confirmNewItem()
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
        modelContext.insert(ShoppingItem(ingredient: ingredient, quantity: 1, date: date))
        try? modelContext.save()
        newItemName = ""
        // reste en mode saisie pour enchaîner les ajouts
        isInputFocused = true
    }
    
    func delete(item: ShoppingItem) {
        modelContext.delete(item)
        try? modelContext.save()
    }

    func deleteAllItems() {
        shoppingList.forEach { modelContext.delete($0) }
        try? modelContext.save()
    }
}

#Preview {
    ShoppingList(date: Date())
}
