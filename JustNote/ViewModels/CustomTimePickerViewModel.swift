//
//  CustomTimePickerViewModel.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

class CustomTimePickerViewModel: ObservableObject {
    @Published var selectedDate = Date()
    
    func setReminder(reminderDateBinding: Binding<Date?>, isPresentedBinding: Binding<Bool>) {
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: selectedDate
        )
        reminderDateBinding.wrappedValue = Calendar.current.date(from: components)
        isPresentedBinding.wrappedValue = false
    }
}
