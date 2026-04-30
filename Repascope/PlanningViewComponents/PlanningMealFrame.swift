//
//  PlanningMealFrame.swift
//  Repascope
//
//  Created by Mickael Thibouret on 30/04/2026.
//

import SwiftUI

struct PlanningMealFrame: View {
    
    let day: Date
    let moment: MealMoment
    @State var guests: String = ""
    @State var notes: String = ""
    
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
        }
        .frame(minWidth: 150, maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray)
        }
    }
}

enum MealMoment:String {
    case noon = "Midi"
    case evening = "Soir"
}

#Preview {
    PlanningMealFrame(day: Date(), moment: .noon)
}
