//
//  ReminderInputViewModel.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI
import SwiftData

enum PresetType: CaseIterable {
    case tomorrowMorning
    case in2Hours
    case evening
    case customTemplates
    
    var title: String {
        switch self {
        case .tomorrowMorning: return "Tomorrow Morning"
        case .in2Hours: return "In 2 Hours"
        case .evening: return "This Evening"
        case .customTemplates: return "My Templates"
        }
    }
    
    var icon: String {
        switch self {
        case .tomorrowMorning: return "sunrise"
        case .in2Hours: return "clock.badge"
        case .evening: return "moon"
        case .customTemplates: return "folder"
        }
    }
}

class ReminderInputViewModel: ObservableObject {
    @Published var showCustomPicker = false
    @Published var showTemplateCreator = false
    @Published var showCustomTemplates = false
    @Published var showTimePicker = false
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func handlePreset(_ preset: PresetType, reminderDateBinding: Binding<Date?>, isPresentedBinding: Binding<Bool>) {
        switch preset {
        case .tomorrowMorning:
            setTime(hour: 8, minute: 0, reminderDateBinding: reminderDateBinding, isPresentedBinding: isPresentedBinding)
        case .in2Hours:
            setReminder(minutes: 120, reminderDateBinding: reminderDateBinding, isPresentedBinding: isPresentedBinding)
        case .evening:
            setTime(hour: 19, minute: 0, reminderDateBinding: reminderDateBinding, isPresentedBinding: isPresentedBinding)
        case .customTemplates:
            withAnimation {
                showCustomTemplates.toggle()
            }
        }
    }
    
    func setTime(hour: Int, minute: Int, reminderDateBinding: Binding<Date?>, isPresentedBinding: Binding<Bool>) {
        let components = DateComponents(hour: hour, minute: minute)
        reminderDateBinding.wrappedValue = Calendar.current.nextDate(
            after: Date(),
            matching: components,
            matchingPolicy: .nextTime
        )
        isPresentedBinding.wrappedValue = false
    }
    
    func refreshTemplates() {
        modelContext.processPendingChanges()
    }
    
    func setReminder(minutes: Int, reminderDateBinding: Binding<Date?>, isPresentedBinding: Binding<Bool>) {
        guard let newDate = Calendar.current.date(
            byAdding: .minute,
            value: minutes,
            to: Date()
        ) else { return }
        
        reminderDateBinding.wrappedValue = Calendar.current.date(
            bySetting: .second,
            value: 0,
            of: newDate
        )
        isPresentedBinding.wrappedValue = false
    }
    
    func deleteTemplate(_ template: ReminderTemplate) {
        modelContext.delete(template)
        do {
            try modelContext.save()
        } catch {
            print("Error deleting template: \(error.localizedDescription)")
        }
    }
    
    func colorForTemplate(_ template: ReminderTemplate, nebulaPalette: [Color]) -> Color {
        let hash = template.id.hashValue
        return nebulaPalette[abs(hash) % nebulaPalette.count]
    }
}
