//
//  ShoppingItem.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI

struct ShoppingItem: View {
    
    let item: String
    @State var quantity: Int
    @State var isChecked: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "inset.filled.circle" : "circle")
                .font(.system(size: 18))
            Text(item)
                .fontWeight(.bold)
            if quantity != 1 {
                Text("x \(quantity)")
            }
            
            Spacer()
            
            Button { quantity += 1 } label: { Image(systemName: "plus.circle") }
                .buttonStyle(.plain)
            Button { quantity -= 1 } label: { Image(systemName: "minus.circle") }
                .buttonStyle(.plain)
            
        }
        .opacity(isChecked ? 0.5 : 1)
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

#Preview {
    ShoppingItem(item: "Pâte brisée", quantity: 2)
}
