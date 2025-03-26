//
//  NotesViewModel.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI
import SwiftData
import UserNotifications

enum SortOption: String, CaseIterable {
    case date = "Sort By Date"
    case alphabet = "Sort By Alphabet"
}

class NotesViewModel: ObservableObject {
    @Published var newNoteText: String = ""
    @Published var sortOption: SortOption = .date
    @Published var selectedCategory: NoteCategory = .general
    @Published var isSearchVisible: Bool = false
    @Published var searchText: String = ""
    @Published var isDarkMode: Bool = false
    @Published var isSelectionMode: Bool = false
    @Published var selectedNotes: Set<UUID> = []
    
    let modelContext: ModelContext
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func filteredNotes(_ notes: [Note]) -> [Note] {
        notes.filter { note in
            (searchText.isEmpty || note.text.localizedCaseInsensitiveContains(searchText))
        }
    }
    
    func groupedSortedNotes(_ notes: [Note]) -> [NoteCategory: [Note]] {
        Dictionary(grouping: filteredNotes(notes), by: { $0.category }).mapValues { notes in
            let (pinned, unpinned) = notes.reduce(into: (pinned: [Note](), unpinned: [Note]())) { result, note in
                note.isPinned ? result.pinned.append(note) : result.unpinned.append(note)
            }
            
            let sortedPinned = sortNotes(pinned)
            let sortedUnpinned = sortNotes(unpinned)
            
            return sortedPinned + sortedUnpinned
        }
    }
    
    func sortNotes(_ notes: [Note]) -> [Note] {
        notes.sorted { lhs, rhs in
            switch sortOption {
            case .date:
                return lhs.createdAt > rhs.createdAt
            case .alphabet:
                return lhs.text.localizedCompare(rhs.text) == .orderedAscending
            }
        }
    }
    
    // MARK: - CRUD Operations
    func addNote() {
        guard !newNoteText.isEmpty else { return }
        let newNote = Note(text: newNoteText, category: selectedCategory)
        modelContext.insert(newNote)
        newNoteText = ""
    }
    
    func toggleSelection(for note: Note) {
        if selectedNotes.contains(note.id) {
            selectedNotes.remove(note.id)
        } else {
            selectedNotes.insert(note.id)
        }
    }
    
    func toggleFavorite(_ note: Note) {
        note.isFavorite.toggle()
    }
    
    func togglePin(_ note: Note) {
        note.isPinned.toggle()
    }
    
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
    
    func deleteNote(_ note: Note) {
        cancelReminder(for: note)
        modelContext.delete(note)
    }
    
    // MARK: - Reminder Functions
    func toggleReminder(for note: Note) {
        note.showReminderInput = true
    }
    
    func scheduleNotification(for note: Note) {
        guard let reminderDate = note.reminderDate else { return }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else { return }
            
            let content = UNMutableNotificationContent()
            content.title = "Reminder ⏰"
            content.body = note.text
            content.sound = .default
            
            let components = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: reminderDate
            )
            
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: false
            )
            
            let request = UNNotificationRequest(
                identifier: note.id.uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func checkExpiredReminders(_ notes: [Note]) {
        let now = Date()
        for note in notes {
            if let reminderDate = note.reminderDate, reminderDate <= now {
                note.reminderDate = nil
            }
        }
    }
    
    func cancelReminder(for note: Note) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [note.id.uuidString])
        note.reminderDate = nil
    }
}
