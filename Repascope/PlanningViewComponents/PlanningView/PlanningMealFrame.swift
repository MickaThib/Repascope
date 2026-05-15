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
    @State private var targetedReplacementID: PersistentIdentifier?
    
    
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
                // Si un seul repas est prévu : prévoir espace "plus" pour en ajouter un autre
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
            .fill(isTargeted ? Color.accentColor.opacity(0.15) : Color.gray.opacity(0.2))
            .frame(minHeight: 40, maxHeight: .infinity)
            .padding(.horizontal, 7)
            .padding(.bottom, 7)
            .overlay {
                Text("Aucun repas prévu")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isTargeted ? Color.accentColor : Color.clear,lineWidth: 2)
                    .padding(.horizontal, 7)
                    .padding(.bottom, 7)
            }
            .dropDestination(for: MealTransfer.self) { transfers, _ in
                handleMealDrop(transfers)
            } isTargeted: { targeted in
                isTargeted = targeted
            }
    }
    
    private var singleMealView: some View {
        HStack {
            if let plannedMeal = plannedMeals.first {
                replaceableMealItem(for: plannedMeal)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .fill(.clear)
                .frame(maxWidth: 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isTargeted ? Color.accentColor : Color.gray.opacity(0.2), lineWidth: isTargeted ? 2 : 1)
                }
                .overlay {
                    Image(systemName: "plus")
                }
                // Drop pour ajouter un meal en case secondaire
                .dropDestination(for: MealTransfer.self) { transfers, _ in
                    handleMealDrop(transfers)
                } isTargeted: { targeted in
                    isTargeted = targeted
                }
        }
        .padding(.horizontal, 7)
        .padding(.bottom, 7)
    }
    
    private var multipleMealsView: some View {
        HStack {
            ForEach(plannedMeals) { plannedMeal in
                replaceableMealItem(for: plannedMeal)
            }
        }
        .padding(.horizontal, 7)
        .padding(.bottom, 7)
    }
    
    private func handleMealDrop(_ transfers: [MealTransfer]) -> Bool {
        guard let transfer = transfers.first else {
            return false
        }

        guard let meal = modelContext.model(for: transfer.persistentID) as? MealItem else {
            print("🔴 meal introuvable")
            return false
        }

        viewModel.setPlannedMeal(
            meal,
            date: day,
            slot: slot,
            existingPlannedMeals: plannedMeals,
            modelContext: modelContext
        )

        return true
    }
    
    private func handleMealReplacementDrop(_ transfers: [MealTransfer], replacing plannedMeal: PlannedMeal) -> Bool {
        guard let transfer = transfers.first else {
            return false
        }
        
        guard let meal = modelContext.model(for: transfer.persistentID) as? MealItem else {
            print("🔴 meal introuvable")
            return false
        }
        
        viewModel.replaceMeal(
            in: plannedMeal,
            with: meal,
            modelContext: modelContext
        )
        
        return true
    }
    
    private func replaceableMealItem(for plannedMeal: PlannedMeal) -> some View {
        PlanningMealItem(
            meal: plannedMeal.meal,
            deleteAction: {
                viewModel.delete(
                    plannedMeal: plannedMeal,
                    modelContext: modelContext
                )
            }
        )
        .frame(minHeight: 40, maxHeight: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    targetedReplacementID == plannedMeal.persistentModelID
                    ? Color.accentColor
                    : Color.clear,
                    lineWidth: 2
                )
        }
        .dropDestination(for: MealTransfer.self) { transfers, _ in
            handleMealReplacementDrop(
                transfers,
                replacing: plannedMeal
            )
        } isTargeted: { targeted in
            targetedReplacementID = targeted ? plannedMeal.persistentModelID : nil
        }
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
