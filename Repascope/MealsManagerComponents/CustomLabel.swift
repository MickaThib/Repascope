//
//  CustomLabel.swift
//  Repascope
//
//  Created by Mickael on 02/05/2026.
//

import SwiftUI

struct CustomLabel: View {
    
    let title:String
    let type: LabelType
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)
                    .padding(.leading)
                Spacer()
                Image(systemName: "pencil")
                Image(systemName: "xmark")
                    .padding(.trailing)
            }

            
            switch (type) {
            case .ingredient:
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.green.opacity(0.2))
            case .meal:
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.blue.opacity(0.2))
            }

        }
        .frame(maxWidth: .infinity)
    }
}

enum LabelType {
    case ingredient
    case meal
}

#Preview {
    CustomLabel(title: "Côtes de porc", type: .meal)
}
