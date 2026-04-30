//
//  ContentView.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedItem: sideBarItem = .planning
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List(selection: $selectedItem) {
                    NavigationLink(value: sideBarItem.planning) {
                        Label("Planning", systemImage: "calendar")
                    }
                    NavigationLink(value: sideBarItem.meals) {
                        Label("Plats", systemImage: "fork.knife")
                    }
                    NavigationLink(value: sideBarItem.guests) {
                        Label("Convives", systemImage: "person.2.fill")
                    }
                    
                }
                .listStyle(.sidebar)
                .scrollDisabled(true)
                
                List(selection: $selectedItem) {
                    NavigationLink(value: sideBarItem.settings) {
                        Label("Réglages", systemImage: "gear")
                    }
                }
                .listStyle(.sidebar)
                .scrollDisabled(true)
                .frame(height: 40)
            }
            .navigationTitle("Repascope")
            .navigationSplitViewColumnWidth(160)
        } detail: {
            switch selectedItem {
            case .planning:
                OrganizerView()
            case .meals:
                Text("Repas à venir")
            case .guests:
                Text("Convives à venir")
            case .settings:
                Text("Réglages à venir")
            }
        }
    }
}

enum sideBarItem {
    case planning
    case meals
    case guests
    case settings
}

#Preview {
    ContentView()
        .modelContainer(for: Guest.self, inMemory: true)
}
