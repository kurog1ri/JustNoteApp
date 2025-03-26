//
//  NotesListView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct NotesListView: View {
    let notes: [Note]
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        let groupedNotes = viewModel.groupedSortedNotes(notes)
        
        return List {
            ForEach(NoteCategory.allCases, id: \.self) { category in
                if let categoryNotes = groupedNotes[category], !categoryNotes.isEmpty {
                    Section(header: Text(category.rawValue).font(.headline)) {
                        ForEach(categoryNotes) { note in
                            NoteRowView(note: note, viewModel: viewModel)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                        .onDelete { indices in
                            for index in indices {
                                let note = categoryNotes[index]
                                viewModel.deleteNote(note)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}
