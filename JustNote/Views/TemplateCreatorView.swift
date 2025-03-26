//
//  TemplateCreatorView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 15.02.2025.
//

import SwiftUI
import SwiftData

// MARK: - Template Creator View
struct TemplateCreatorView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    var onSave: () -> Void
    @State private var templateName = ""
    @State private var minutes = 15
        
    var body: some View {
        VStack(spacing: 24) {
            Text("New Template")
                .font(.system(.title2, design: .rounded).weight(.heavy))
                .foregroundStyle(CosmicGradient.main)
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Template Name")
                    .font(.system(.subheadline, design: .rounded).weight(.medium))
                    .foregroundColor(.indigo.opacity(0.5))
                
                TextField("", text: $templateName)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(CosmicGradient.main, lineWidth: 1)
                            )
                    )
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Duration")
                    .font(.system(.subheadline, design: .rounded).weight(.medium))
                    .foregroundColor(.indigo.opacity(0.5))
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundStyle(CosmicGradient.main)
                    
                    Stepper("\(minutes) minutes", value: $minutes, in: 1...1440)
                        .font(.system(.body, design: .rounded))
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(CosmicGradient.main, lineWidth: 1)
                        )
                )
            }
            .padding(.horizontal)
            
            HStack(spacing: 16) {
                CosmicActionButton(
                    title: "Cancel",
                    systemImage: "xmark.circle",
                    color: .teal,
                    action: { isPresented = false }
                )
                
                CosmicActionButton(
                    title: "Save",
                    systemImage: "checkmark.circle",
                    color: .purple.opacity(2.5),
                    action: saveTemplate,
                    disabled: templateName.isEmpty
                )
            }
            .padding(.horizontal)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
        )
        .padding(20)
    }
    
    // MARK: - Saves
    private func saveTemplate() {
        let newTemplate = ReminderTemplate(
            name: templateName,
            minutes: minutes
        )
        modelContext.insert(newTemplate)
        do {
            try modelContext.save()
            isPresented = false
            onSave()
        } catch {
            print("Error saving template: \(error.localizedDescription)")
        }
    }
}

