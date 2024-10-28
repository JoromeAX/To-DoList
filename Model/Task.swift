//
//  Task.swift
//  To-DoList
//
//  Created by Roman Khancha on 11.10.2024.
//

import Foundation
import SwiftData

@Model
class Task {
    @Attribute() var id: UUID
    var tittle: String
    var details: String?
    var priority: Int
    var date: Date
    
    init(tittle: String, details: String? = nil, priority: Int, date: Date) {
        self.id = UUID()
        self.tittle = tittle
        self.details = details
        self.priority = priority
        self.date = date
    }
}
