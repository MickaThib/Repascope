//
//  ConvivesField.swift
//  Repascope
//
//  Created by THIBOURET  Mickael on 04/06/2026.
//

import SwiftUI
import SwiftData

struct ConvivesField: View {
    @Environment(\.modelContext) private var modelContext

    let day: Date
    let slot: MealSlot
    let plannedMeals: [PlannedMeal]
    let allGuests: [Guest]
    let allGroups: [GuestsGroup]

    private var selectedGuests: [Guest] {
        unique(plannedMeals.flatMap(\.guests))
    }

    private var selectedGroups: [GuestsGroup] {
        unique(plannedMeals.flatMap(\.guestsGroups))
    }

    var body: some View {
        HStack(spacing: 6) {
            
            if selectedGroups.isEmpty && selectedGuests.isEmpty {
                Text("Ajouter des convives")
                    .font(.callout)
                    .foregroundStyle(slot.color())
            }
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 6) {
                    ForEach(selectedGuests) { guest in
                        chip(title: guest.name) {
                            removeGuest(guest)
                        }
                    }

                    ForEach(selectedGroups) { group in
                        chip(title: group.title) {
                            removeGroup(group)
                        }
                    }
                }
            }

            Menu {
                Section("Groupes") {
                    ForEach(availableGroups) { group in
                        Button {
                            addGroup(group)
                        } label: {
                            Text(group.title)
                        }
                    }
                }
                
                Section("Convives") {
                    ForEach(availableGuests) { guest in
                        Button {
                            addGuest(guest)
                        } label: {
                            Text(guest.name)
                        }
                    }
                }
            } label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }
            .menuStyle(.borderlessButton)
            .tint(slot.color().opacity(1))
        }
        .padding(6)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(slot.color())
        }
    }

    private var availableGuests: [Guest] {
        allGuests.filter { guest in
            !selectedGuests.contains {
                $0.persistentModelID == guest.persistentModelID
            }
        }
    }

    private var availableGroups: [GuestsGroup] {
        allGroups.filter { group in
            !selectedGroups.contains {
                $0.persistentModelID == group.persistentModelID
            }
        }
    }
    
    private func ensurePlannedMeal() -> [PlannedMeal] {
        if !plannedMeals.isEmpty {
            return plannedMeals
        }

        let plannedMeal = PlannedMeal(
            date: day,
            slot: slot,
            position: 0
        )

        modelContext.insert(plannedMeal)

        return [plannedMeal]
    }

    private func addGuest(_ guest: Guest) {
        let meals = ensurePlannedMeal()

        for plannedMeal in meals {
            if !plannedMeal.guests.contains(where: {
                $0.persistentModelID == guest.persistentModelID
            }) {
                plannedMeal.guests.append(guest)
            }
        }

        try? modelContext.save()
    }

    private func addGroup(_ group: GuestsGroup) {
        let meals = ensurePlannedMeal()

        for plannedMeal in meals {
            if !plannedMeal.guestsGroups.contains(where: {
                $0.persistentModelID == group.persistentModelID
            }) {
                plannedMeal.guestsGroups.append(group)
            }
        }

        try? modelContext.save()
    }

    private func removeGuest(_ guest: Guest) {
        for plannedMeal in plannedMeals {
            plannedMeal.guests.removeAll {
                $0.persistentModelID == guest.persistentModelID
            }
        }

        try? modelContext.save()
    }

    private func removeGroup(_ group: GuestsGroup) {
        for plannedMeal in plannedMeals {
            plannedMeal.guestsGroups.removeAll {
                $0.persistentModelID == group.persistentModelID
            }
        }

        try? modelContext.save()
    }

    private func chip(title: String, remove: @escaping () -> Void) -> some View {
        HStack(spacing: 4) {
            Text(title)

            Button {
                remove()
            } label: {
                Image(systemName: "xmark.circle")
            }
            .buttonStyle(.plain)
        }
        .font(.caption)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(.white.opacity(0.8), in: Capsule())
    }

    private func unique<T: PersistentModel>(_ items: [T]) -> [T] {
        var seen = Set<PersistentIdentifier>()

        return items.filter { item in
            seen.insert(item.persistentModelID).inserted
        }
    }
}

#Preview {
    ConvivesField(
        day: Date(),
        slot: .evening,
        plannedMeals: [],
        allGuests: [],
        allGroups: [])
}
