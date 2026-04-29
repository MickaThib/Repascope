//
//  ShoppingItem.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI

struct ShoppingItem: View {
    
    let item: String
    let quantity: Int
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
