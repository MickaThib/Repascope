//
//  PlanningView.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI

struct PlanningView: View {
    var body: some View {
        HStack(spacing: 0) {
            //MARK: Contenu principal
            VStack {
                Text("Planning à venir")
            }
            .frame(maxWidth: .infinity)
            
            //MARK: Volet droit
            VSplitView {
                //Section haute
                VStack (alignment: .leading, spacing: 0) {
                    Text("Plats")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    Divider()
                    List {
                        ForEach(0..<10) { i in
                            Text("Plat \(i)")
                        }
                    }
                    .listStyle(.plain)
                }
                .frame(minHeight: 100) // hauteur minimale pour éviter l'écrasement
                
                //Section basse
                VStack (alignment: .leading, spacing: 0) {
                    Text("Achats")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    Divider()
                    List {
                        ForEach(0..<10) { i in
                            Text("Achat \(i)")
                        }
                    }
                    .listStyle(.plain)
                }
                .frame(minHeight: 100) // hauteur minimale pour éviter l'écrasement
            }
            .frame(width: 280)
        }
    }
}

#Preview {
    PlanningView()
}
