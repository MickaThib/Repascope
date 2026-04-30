//
//  PlanningLine.swift
//  Repascope
//
//  Created by Mickael Thibouret on 30/04/2026.
//

import SwiftUI

struct PlanningLine: View {
    
    let day: Date
    
    var body: some View {
        HStack {
            VStack {
                Text(day.formatted(.dateTime.weekday(.wide)))
                    .font(.system(size: 14, weight: .bold))
                    .textCase(.uppercase)
                Text(day.formatted(.dateTime.day().month(.wide)))
                    .font(.system(size: 10))
            }
            .frame(width: 150)
            .frame(maxHeight: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray)
            }
            
            
            PlanningMealFrame(day: day, moment: .noon)
                .frame(maxHeight: .infinity)

            PlanningMealFrame(day: day, moment: .evening)
                .frame(maxHeight: .infinity)

        }
    }
}

#Preview {
    PlanningLine(day: Date())
}
