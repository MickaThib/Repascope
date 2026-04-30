//
//  PlanningViewComponent.swift
//  Repascope
//
//  Created by Mickael Thibouret on 30/04/2026.
//

import SwiftUI

struct PlanningView: View {
    
    let calendarViewModel = CalendarViewModel()
    @State var weekToDisplay: Date = Date()
    
    var body: some View {
        ScrollView {
            //MARK: Navigation buttons
            HStack {
                Button("Semaine précedente") {
                    if let newWeekToDisplay = calendarViewModel.calendar.date(byAdding: .day, value: -7, to: weekToDisplay) {
                        weekToDisplay = newWeekToDisplay
                    }
                }
                
                Button("Cette semaine") {
                    weekToDisplay = Date()
                }

                Button("Semaine suivante") {
                    if let newWeekToDisplay = calendarViewModel.calendar.date(byAdding: .day, value: 7, to: weekToDisplay) {
                        weekToDisplay = newWeekToDisplay
                    }
                }
            }
            if let days = calendarViewModel.generateWeek(from: weekToDisplay, firstDay: .friday)?.days {
                ForEach(days, id: \.self) { day in
                    PlanningLine(day: day)
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    PlanningView()
}
