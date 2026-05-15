//
//  PlanningViewModel.swift
//  Repascope
//
//  Created by Mickael on 15/05/2026.
//

import Foundation
import SwiftData

@MainActor
final class PlanningViewModel {

    private let calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "fr_FR")
        cal.firstWeekday = 2
        return cal
    }()

    func planned(for date: Date, slot: MealSlot, in plannedMeals: [PlannedMeal]) -> [PlannedMeal] {
        let day = calendar.startOfDay(for: date)

        return plannedMeals
            .filter { plannedMeal in
                calendar.isDate(plannedMeal.date, inSameDayAs: day)
                && plannedMeal.slot == slot
            }
            .sorted { $0.position < $1.position }
    }

    func delete(plannedMeal: PlannedMeal?, modelContext: ModelContext) {
        guard let plannedMeal else {
            return
        }

        modelContext.delete(plannedMeal)

        do {
            try modelContext.save()
        } catch {
            print("Error deleting plannedMeal : \(plannedMeal.meal?.title ?? "Unknown")")
            print(error)
        }
    }

    func setPlannedMeal(_ meal: MealItem, date: Date, slot: MealSlot, existingPlannedMeals: [PlannedMeal], modelContext: ModelContext) {
        
        let mealsForSlot = planned(for: date, slot: slot, in: existingPlannedMeals)

        guard mealsForSlot.count < 2 else {
            print("Il y a déjà deux repas pour ce créneau.")
            return
        }

        let day = calendar.startOfDay(for: date)

        let plannedMeal = PlannedMeal(
            date: day,
            slot: slot,
            position: mealsForSlot.count,
            meal: meal
        )

        modelContext.insert(plannedMeal)

        do {
            try modelContext.save()
        } catch {
            print("Error saving plannedMeal")
            print(error)
        }
    }
    
    func replaceMeal(in plannedMeal:PlannedMeal, with newMeal:MealItem, modelContext:ModelContext) {
        
        plannedMeal.meal = newMeal
        
        do {
                try modelContext.save()
            } catch {
                print("Error replacing plannedMeal")
                print(error)
            }
    }
}
