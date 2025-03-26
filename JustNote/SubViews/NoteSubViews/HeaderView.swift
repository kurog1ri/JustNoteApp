//
//  HeaderView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: NotesViewModel
    let notesCount: Int
    
    var body: some View {
        HStack {
            TextField("Enter note...🖋️", text: $viewModel.newNoteText)
                .textFieldStyle(.plain)
                .padding(8)
                .background(Color.cardBackground)
                .cornerRadius(10)
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    viewModel.addNote()
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.customAccent)
                    .symbolEffect(.bounce, value: notesCount)
            }
            .buttonStyle(ScaleButtonStyle())
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    viewModel.isSearchVisible.toggle()
                }
            }) {
                Image(systemName: "magnifyingglass.circle")
                    .font(.title2)
            }
            
            Menu {
                Picker("Category", selection: $viewModel.selectedCategory) {
                    ForEach(NoteCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
            } label: {
                Image(systemName: "pencil.and.outline")
                    .font(.title2)
            }
            
            Menu {
                Button(action: { viewModel.isSelectionMode.toggle() }) {
                    Label("Select", systemImage: "checkmark.circle")
                }
                Picker("Sort by", selection: $viewModel.sortOption) {
                    Label("Sort By Date", systemImage: "calendar.circle").tag(SortOption.date)
                    Label("Sort By Alphabet", systemImage: "a.circle").tag(SortOption.alphabet)
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title2)
            }
            
            Button(action: viewModel.toggleDarkMode) {
                Image(systemName: viewModel.isDarkMode ? "moon.stars.fill" : "sun.max.fill")
                    .font(.title2)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(viewModel.isDarkMode ? .yellow : .orange)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
