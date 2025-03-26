//
//  ReminderTemplate.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 15.02.2025.
//

import SwiftUI
import SwiftData

@Model
class ReminderTemplate {
    var id: UUID
    var name: String
    var minutes: Int
    
    init(name: String, minutes: Int) {
        self.id = UUID()
        self.name = name
        self.minutes = minutes
    }
}

