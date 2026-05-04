//
//  MealsManagerList.swift
//  Repascope
//
//  Created by Mickael Thibouret on 04/05/2026.
//

import SwiftUI
import SwiftData

struct MealsManagerList: View {
    
    let items: [any ListableItem]
    let type: ListLabelType
    
    @Binding var selectedItem: (any ListableItem)?
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(alignment: .lastTextBaseline) {
                
                Text(type.rawValue)
                    .font(.largeTitle)
                    .padding(.top)
                    .padding(.horizontal)

                Spacer()
                //TODO: Recherche
                TextField("Rechercher", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 150)
                    .padding(.bottom, 1)
                Button {
                    //TODO: Ajouter un ingrédient ou un plat
                } label: {
                    Label("Ajouter", systemImage: "plus")
                }
                .padding(.trailing)
                .buttonStyle(.borderless)
            }
            .padding(.horizontal)
            
            List(items, id: \.id) { item in
                CustomLabel(
                    title: item.displayName,
                    type: type,
                    isSelected: selectedItem === item // triple "=" -> Comparaison par référence
                )
                    .listRowSeparator(.hidden)
                    .frame(height: 30)
                    .onTapGesture {
                        selectedItem = item
                    }
            }
            .padding(.top, 0)
            
            Divider()
        }
    }
}

#Preview {
    let mealsDataTest = [
        MealItem(title: "Raclette", photo: nil, ingredients: []),
        MealItem(title: "Hamburger maison", photo: nil, ingredients: []),
        MealItem(title: "Hot dogs", photo: nil, ingredients: []),
        MealItem(title: "Poisson pané", photo: nil, ingredients: []),
        MealItem(title: "Quiche lorraine", photo: nil, ingredients: []),
        MealItem(title: "Lasagnes", photo: nil, ingredients: [])
    ]
    
    MealsManagerList(items: mealsDataTest, type: .meal, selectedItem: .constant(MealItem(title: "Machin", photo: nil)))
}
