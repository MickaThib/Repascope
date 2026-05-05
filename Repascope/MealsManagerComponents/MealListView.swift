//
//  MealsManagerList.swift
//  Repascope
//
//  Created by Mickael Thibouret on 04/05/2026.
//

import SwiftUI
import SwiftData

struct MealListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \MealItem.title) private var meals: [MealItem]
    
    @Binding var selectedMeal: MealItem?
    @State var showDeleteAlert: Bool = false
    @State private var mealToDelete: MealItem?
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(alignment: .lastTextBaseline) {
                
                Text("Repas")
                    .font(.largeTitle)
                    .padding(.top)
                    .padding(.horizontal)

                Spacer()
                
                Button {
                    //TODO: Ajouter un plat
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
            
            List(meals, id: \.id) { meal in
                CustomLabel(
                    title: meal.title,
                    type: .meal,
                    isSelected: selectedMeal === meal, // triple "=" -> Comparaison par référence
                    deleteAction: {
                        mealToDelete = meal
                        showDeleteAlert = true
                    }
                )
                    .listRowSeparator(.hidden)
                    .frame(height: 30)
                    .onTapGesture {
                        selectedMeal = meal
                    }
            }
            .padding(.top, 0)
        }
        .alert("Supprimer \(mealToDelete?.title ?? "ce repas") ?", isPresented: $showDeleteAlert) {
            Button("Annuler", role: .cancel){
                mealToDelete = nil
            }
            Button("Supprimer", role: .destructive){
                if let meal = mealToDelete {
                    modelContext.delete(meal)
                    try? modelContext.save()
                }
                mealToDelete = nil
            }
        }
    }
}

#Preview {    
    MealList()
}
