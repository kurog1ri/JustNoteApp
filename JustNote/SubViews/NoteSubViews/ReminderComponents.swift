//
//  ReminderComponents.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct ReminderBadge: View {
    let reminderDate: Date
    
    var body: some View {
        HStack {
            Image(systemName: "bell.fill")
                .foregroundColor(.customAccent)
            Text("Reminder: \(reminderDate, style: .relative)")
        }
        .font(.caption)
        .foregroundColor(.customAccent)
        .padding(6)
        .background(Color.customAccent.opacity(0.1))
        .cornerRadius(6)
    }
}


