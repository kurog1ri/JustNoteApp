//
//  EmptyStateView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(systemName: "notequal.square")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            Text("Nah 😩, \n nothing here yet.")
                .multilineTextAlignment(.center)
                .foregroundColor(.accentColor)
                .padding(.horizontal)
        }
        .padding(.top, 100)
    }
}
