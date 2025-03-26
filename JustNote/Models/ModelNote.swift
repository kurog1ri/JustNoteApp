//
//  ModelNote.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 31.01.2025.
//

import SwiftUI
import SwiftData

// MARK: - Note Model
@Model
class Note {
    var id: UUID = UUID()
    var text: String
    var createdAt: Date
    var isFavorite: Bool = false
    var isPinned: Bool = false
    var category: NoteCategory
    var reminderDate: Date?
    var showReminderInput: Bool = false 
    
    init(text: String, category: NoteCategory = .general, createdAt: Date = Date()) {
        self.text = text
        self.category = category
        self.createdAt = createdAt
    }
}

enum NoteCategory: String, CaseIterable, Codable {
    case general = "General 📎"
    case sport = "Sport 🏃"
    case food = "Food 🥗"
    case work = "Work 🧑‍💻"
}



