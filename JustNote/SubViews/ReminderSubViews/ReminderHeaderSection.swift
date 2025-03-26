//
//  ReminderHeaderSection.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct ReminderHeaderSection: View {
    let cosmicGradient: LinearGradient
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Set Reminder")
                .font(.system(.title2, design: .rounded).weight(.heavy))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(cosmicGradient)
                        .shadow(color: .purple.opacity(0.4), radius: 10, x: 0, y: 4)
                )
                .padding(.horizontal, 16)
            
            LinearGradient(
                colors: [.clear, .purple.opacity(0.1), .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 1)
            .padding(.vertical, 12)
        }
    }
}
