//
//  PlanningLine.swift
//  Repascope
//
//  Created by Mickael Thibouret on 30/04/2026.
//

import SwiftUI

struct PlanningLine: View {
    
    let day: Date
    
    let calendar: Calendar = {
            var cal = Calendar(identifier: .gregorian)
            cal.locale = Locale(identifier: "fr_FR")
            cal.firstWeekday = 2
            return cal
        }()
    
    var isToday: Bool { calendar.isDateInToday(day) }
    
    var body: some View {
        HStack {
            VStack {
                Text(day.formatted(.dateTime.weekday(.wide)))
                    .font(.system(size: 14, weight: .bold))
                    .textCase(.uppercase)
                    .foregroundStyle(isToday ? Color.accentColor : Color.primary)
                Text(day.formatted(.dateTime.day().month(.wide)))
                    .font(.system(size: 10))
                    .foregroundStyle(isToday ? Color.accentColor : Color.primary)
            }
            .frame(width: 150)
            .frame(maxHeight: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isToday ? Color.accentColor : Color.gray)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(isToday ? Color.accentColor.opacity(0.1) : Color.clear)
            )
            
            
            PlanningMealFrame(day: day, moment: .noon)

            PlanningMealFrame(day: day, moment: .evening)

        }
        .frame(height: 80)
        .padding(1)
    }
}

#Preview {
    PlanningLine(day: Date())
}
