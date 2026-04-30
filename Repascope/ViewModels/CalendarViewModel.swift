//
//  CalendarViewModel.swift
//  Planingo
//
//  Created by Mickael on 20/02/2026.
//

import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    
    @Published var weeks: [Week] = []
    
    let calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "fr_FR")
        cal.firstWeekday = 2
        return cal
    }()
    
    var currentWeekID: Date? {
        let today = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        return calendar.date(from: components)
    }
    
    init() {
        generateWeeks()
    }
    
    func generateWeeks() {
        
        let today = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        guard let startOfCurrentWeek = calendar.date(from: components) else {return}
        
        for i in -5...10{
            if let startOfWeek = calendar.date(byAdding: .weekOfYear, value: i, to: startOfCurrentWeek) {
                let days = (0..<5).compactMap { // 0..<5 pour les jours de travail, 0..<7 pour tous les jours de la semaine
                    calendar.date(byAdding: .day, value: $0, to: startOfWeek)
                }
                weeks.append(Week(id: startOfWeek, days: days))
            }
        }
        
    }
}
