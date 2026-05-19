//
//  PlanningViewComponent.swift
//  Repascope
//
//  Created by Mickael Thibouret on 30/04/2026.
//

import SwiftUI
import SwiftData

struct PlanningView: View {
    
    let weekToDisplay: Date
    
    private let calendarViewModel = CalendarViewModel()
    private let planningViewModel = PlanningViewModel()
    
    @Query(sort: \PlannedMeal.date)
    private var allPlannedMeals: [PlannedMeal]

    var body: some View {
        
        ScrollView {
            
            HStack {
                Spacer().frame(width: 158)
                
                Text("MIDI")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.noon)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.noon.opacity(0.1))
                    )

                Text("SOIR")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.evening)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.evening.opacity(0.1))
                    )
            }
            .padding(.vertical, 0)
            
            if let days = calendarViewModel.generateWeek(
                from: weekToDisplay,
                firstDay: .friday
            )?.days {
                ForEach(days, id: \.self) { day in
                    PlanningLine(
                        day: day,
                        viewModel: planningViewModel,
                        plannedMeals: allPlannedMeals
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    PlanningView(weekToDisplay: Date())
}
