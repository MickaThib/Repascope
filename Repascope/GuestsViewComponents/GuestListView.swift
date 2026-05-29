//
//  GuestListView.swift
//  Repascope
//
//  Created by Mickael Thibouret on 29/05/2026.
//

import SwiftUI

struct GuestListView: View {
    
    let guests: [Guest]
    
    var body: some View {
        VStack {
            
            HStack(alignment: .lastTextBaseline) {
                
                Text("Convives")
                    .font(.system(size: 24, weight: .bold))

                Spacer()
                
                Button {
                    //TODO: Add guest
                } label: {
                    Label("Ajouter", systemImage: "plus")
                }
                .padding(.trailing)
                .buttonStyle(.borderless)
            }
            .foregroundStyle(Color.white)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(
                Color.theme
            )
            
            List {
                ForEach(guests) { guest in
                    GuestListLineView(guest: guest, editAction: {
                        //TODO: Edit guest
                    })
                    .frame(height: 50)
                }
            }
        }
    }
}

#Preview {
    GuestListView(guests: [
        Guest(name: "Mickael", colorHex: "4076f5"),
        Guest(name: "Marie", colorHex: "f540a7"),
        Guest(name: "Soline", colorHex: "f5bf40"),
        Guest(name: "Erwann", colorHex: "5a6282"),
        Guest(name: "Margaux", colorHex: "44b393"),
    ])
}
