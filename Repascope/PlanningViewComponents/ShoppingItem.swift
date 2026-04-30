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
    var deleteAction: (() -> Void)?
    @State var showDeleteAlert = false
    
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
            Button {
                if quantity > 1 {
                    quantity -= 1
                } else {
                    showDeleteAlert = true
                }
            } label: { Image(systemName: "minus.circle") }
                .buttonStyle(.plain)
            
        }
        .opacity(isChecked ? 0.5 : 1)
        .onTapGesture {
            isChecked.toggle()
        }
        .alert("Supprimer \(item) ?", isPresented: $showDeleteAlert) {
            Button("Supprimer", role: .destructive) { deleteAction?() }
            Button("Annuler", role: .cancel) {}
        }
    }
}

#Preview {
    ShoppingItem(item: "Pâte brisée", quantity: 2, deleteAction: {
        print("delete action")
    })
}
