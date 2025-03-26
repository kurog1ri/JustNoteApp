//
//  TimePickerDateSectionView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct TimePickerDateSectionView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        DatePicker(
            "Select Time",
            selection: $selectedDate,
            in: Date()...Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
            displayedComponents: [.hourAndMinute]
        )
        .datePickerStyle(.graphical)
        .accentColor(Color(hex: 0xFF69B4))
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
        .padding(.horizontal)
    }
}
