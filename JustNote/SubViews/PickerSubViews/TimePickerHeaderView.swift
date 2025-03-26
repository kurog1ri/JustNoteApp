//
//  File.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct TimePickerHeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Select Time")
                .font(.system(.title2, design: .rounded).weight(.heavy))
                .foregroundStyle(CosmicGradient.main)
                .padding(.bottom, 16)
            
            LinearGradient(
                colors: [.clear, .purple.opacity(0.1), .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 1)
        }
        .padding(.horizontal)
    }
}
