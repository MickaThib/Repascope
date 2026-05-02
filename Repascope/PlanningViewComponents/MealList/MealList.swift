//
//  MealList.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI

struct MealList: View {
    
    let mealList: [MealItem] = [
        MealItem(title: "Pâtes carbonara", photo: nil),
        MealItem(title: "Pâtes bolognaise", photo: nil),
        MealItem(title: "Quiche lorraine", photo: nil),
        MealItem(title: "Lasagnes", photo: nil),
        MealItem(title: "Hamburgers maison", photo: nil),
        MealItem(title: "Hot dogs", photo: nil),
        MealItem(title: "Burritos", photo: nil),
        MealItem(title: "Poisson pané", photo: nil),
        MealItem(title: "Crêpes", photo: nil),
        MealItem(title: "Sandwiches", photo: nil),

    ]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                Text("Plats")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                Spacer()
                Button {
                    //TODO: Ajouter un plat
                } label: {
                    Image(systemName: "plus")
                        .padding(.trailing)
                        .font(.system(size: 18))
                }
                .buttonStyle(.plain)

            }
            Divider()
            
            List {
                ForEach(mealList) { meal in
                    MealListItem(meal: meal)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue.opacity(0.3), lineWidth: 3)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.bottom)
    }
}

#Preview {
    MealList()
}
