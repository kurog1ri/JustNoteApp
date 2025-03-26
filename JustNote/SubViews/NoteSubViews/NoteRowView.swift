//
//  NoteRowView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct NoteRowView: View {
    let note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        HStack {
            if viewModel.isSelectionMode {
                SelectionButton(note: note, viewModel: viewModel)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(note.text)
                    .font(.body)
                Text(note.createdAt, format: .dateTime)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let reminderDate = note.reminderDate, reminderDate > Date() {
                    ReminderBadge(reminderDate: reminderDate)
                }
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                FavoriteButton(note: note, viewModel: viewModel)
                PinButton(note: note, viewModel: viewModel)
                ReminderButton(note: note, viewModel: viewModel)
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(12)
        .background(Color.cardBackground)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .transition(.slide)
        .sheet(isPresented: Binding(
            get: { note.showReminderInput },
            set: { note.showReminderInput = $0 }
        )) {
            ReminderInputView(
                reminderDate: Binding(
                    get: { note.reminderDate },
                    set: { newValue in
                        note.reminderDate = newValue
                        if newValue != nil {
                            viewModel.scheduleNotification(for: note)
                        } else {
                            viewModel.cancelReminder(for: note)
                        }
                    }
                ),
                isPresented: Binding(
                    get: { note.showReminderInput },
                    set: { note.showReminderInput = $0 }
                ),
                modelContext: viewModel.modelContext
            )
        }
    }
}
