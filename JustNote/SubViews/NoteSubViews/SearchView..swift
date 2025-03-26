//
//  SearchView..swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        TextField("Search notes...🧐", text: $searchText)
            .textFieldStyle(.plain)
            .padding(5)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}
