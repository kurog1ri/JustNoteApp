//
//  ContentView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 31.01.2025.
//


import SwiftUI
import SwiftData
import UserNotifications

struct NotesView: View {
    @StateObject private var viewModel: NotesViewModel
    @Query private var notes: [Note]
    
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: NotesViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(viewModel: viewModel, notesCount: notes.count)
                
                if viewModel.isSearchVisible {
                    SearchView(searchText: $viewModel.searchText)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
                
                if notes.isEmpty {
                    EmptyStateView()
                } else {
                    NotesListView(notes: notes, viewModel: viewModel)
                }
            }
            .navigationTitle("Just Note 🗒️")
            .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
            .animation(.easeInOut(duration: 1.2), value: viewModel.isDarkMode)
            .onAppear {
                viewModel.checkExpiredReminders(notes)
            }
            .onReceive(viewModel.timer) { _ in
                viewModel.checkExpiredReminders(notes)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Note.self, configurations: config)
        return NotesView(modelContext: container.mainContext)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
