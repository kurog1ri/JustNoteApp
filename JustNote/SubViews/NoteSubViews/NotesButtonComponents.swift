//
//  NotesButtonComponents.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct SelectionButton: View {
    let note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        Button(action: { viewModel.toggleSelection(for: note) }) {
            Image(systemName: viewModel.selectedNotes.contains(note.id) ? "checkmark.circle.fill" : "circle")
                .foregroundColor(.customAccent)
        }
        .padding(.trailing, 8)
    }
}

struct FavoriteButton: View {
    let note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.toggleFavorite(note)
            }
        }) {
            Image(systemName: note.isFavorite ? "heart.fill" : "heart")
                .symbolRenderingMode(.multicolor)
                .font(.title3)
        }
    }
}

struct PinButton: View {
    let note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                viewModel.togglePin(note)
            }
        }) {
            Image(systemName: note.isPinned ? "pin.fill" : "pin")
                .symbolEffect(.bounce, value: note.isPinned)
                .rotationEffect(.degrees(note.isPinned ? 45 : 0))
                .font(.title3)
        }
    }
}

struct ReminderButton: View {
    let note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        Button(action: {
            withAnimation {
                viewModel.toggleReminder(for: note)
            }
        }) {
            Image(systemName: (note.reminderDate ?? Date()) > Date() ? "bell.fill" : "bell")
                .symbolEffect(.scale, isActive: note.reminderDate != nil)
                .font(.title3)
        }
    }
}
