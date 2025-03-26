//
//  CustomRemindPicker.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 02.02.2025.
//

import SwiftUI

// MARK: - Custom Time Picker
struct CustomTimePicker: View {
    @Binding var reminderDate: Date?
    @Binding var isPresented: Bool
    @StateObject private var viewModel = CustomTimePickerViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TimePickerHeaderView()
            TimePickerDateSectionView(selectedDate: $viewModel.selectedDate)
            TimePickerActionButtonsView(isPresented: $isPresented, reminderDate: $reminderDate, viewModel: viewModel)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
        )
        .padding(20)
    }
}

