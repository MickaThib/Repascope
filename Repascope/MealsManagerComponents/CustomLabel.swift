//
//  CustomLabel.swift
//  Repascope
//
//  Created by Mickael on 02/05/2026.
//

import SwiftUI

struct CustomLabel: View {
    
    let title:String
    let type: ListLabelType
    let isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 5)
                .fill(isSelected ? type.ItemColor().opacity(0.2) : type.ItemColor().opacity(0.1))
                .stroke(isSelected ? type.ItemColor() : .clear, lineWidth: 1)
            
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
            
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CustomLabel(title: "Côtes de porc", type: .meal, isSelected: true)
}
