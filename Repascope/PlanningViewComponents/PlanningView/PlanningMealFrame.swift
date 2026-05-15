//
//  PlanningMealFrame.swift
//  Repascope
//
//  Created by Mickael Thibouret on 30/04/2026.
//

import SwiftUI
import SwiftData

struct PlanningMealFrame: View {
    
    @Environment(\.modelContext) private var modelContext
    
    let day: Date
    let slot: MealSlot
    let viewModel:PlanningViewModel
    let plannedMeals:[PlannedMeal]
    
    @State var guests: String = ""
    @State var notes: String = ""
    @State var isTargeted:Bool = false
    
    
    var body: some View {
        VStack {
            HStack {
                TextField("Convives", text: $guests)
                    .textFieldStyle(.plain)
                TextField("Notes", text: $notes)
                    .textFieldStyle(.plain)
            }
            .padding(.horizontal, 7)
            .padding(.top, 7)
            
            if plannedMeals.isEmpty {
                // Si aucun repas n'est prévu
                emptyMealView
                
            } else if plannedMeals.count == 1 {
                // Si un seul repas est prévu : prévoir espace pour en ajouter un autre
                singleMealView
            } else {
                // Si deux repas (ou plus) sont prévus : répartir cases à égalité
                multipleMealsView
            }
        }
        .frame(minWidth: 150, maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray)
        }
    }
    
    private var emptyMealView: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.gray.opacity(0.2))
            .frame(minHeight: 40, maxHeight: .infinity)
            .padding(.horizontal, 7)
            .padding(.bottom, 7)
            .overlay {
                Text("Aucun repas prévu")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            .dropDestination(for: MealTransfer.self) { transfers, _ in
                // TODO: récupérer le MealItem depuis MealTransfer
                // puis appeler viewModel.setPlannedMeal(...)
                return true
            } isTargeted: { targeted in
                isTargeted = targeted
            }
    }
    
    private var singleMealView: some View {
        HStack {
            if let plannedMeal = plannedMeals.first {
                PlanningMealItem(
                    meal: plannedMeal.meal,
                    deleteAction: {
                        viewModel.delete(
                            plannedMeal: plannedMeal,
                            context: modelContext
                        )
                    }
                )
                .frame(minHeight: 40, maxHeight: .infinity)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .fill(.clear)
                .stroke(Color.gray.opacity(0.2))
                .frame(maxWidth: 40)
                .overlay {
                    Image(systemName: "plus")
                }
        }
        .padding(.horizontal, 7)
        .padding(.bottom, 7)
    }
    
    private var multipleMealsView: some View {
        HStack {
            ForEach(plannedMeals) { plannedMeal in
                PlanningMealItem(
                    meal: plannedMeal.meal,
                    deleteAction: {
                        viewModel.delete(
                            plannedMeal: plannedMeal,
                            context: modelContext
                        )
                    }
                )
                .frame(minHeight: 40, maxHeight: .infinity)
            }
        }
        .padding(.horizontal, 7)
        .padding(.bottom, 7)
    }
}

#Preview {
    let meal1 = MealItem(title: "Quiche lorraine", photo: nil)
    let meal2 = MealItem(title: "Haricots verts", photo: nil)
    let pm1 = PlannedMeal(date: Date(), slot: .noon, position: 0, meal: meal1)
    let pm2 = PlannedMeal(date: Date(), slot: .noon, position: 1, meal: meal2)
    
    PlanningMealFrame(
        day: Date(),
        slot: .noon,
        viewModel: PlanningViewModel(),
        plannedMeals: [pm1, pm2]
    )
}
