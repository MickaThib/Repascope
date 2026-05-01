//
//  PlanningViewComponent.swift
//  Repascope
//
//  Created by Mickael Thibouret on 30/04/2026.
//

import SwiftUI

struct PlanningView: View {
    
    let weekToDisplay: Date
    let calendarViewModel = CalendarViewModel()

    var body: some View {
        ScrollView {
            
            if let days = calendarViewModel.generateWeek(from: weekToDisplay, firstDay: .friday)?.days {
                ForEach(days, id: \.self) { day in
                    PlanningLine(day: day)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    PlanningView(weekToDisplay: Date())
}
