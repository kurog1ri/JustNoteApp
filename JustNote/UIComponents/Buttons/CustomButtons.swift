//
//  CustomButtons.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

// MARK: - Custom Buttons Views

// MARK: - Cosmic Button View
struct CosmicButton: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .symbolEffect(.bounce, value: isPressed)
                    .font(.system(size: 20, weight: .bold))
                
                Text(title)
                    .font(.system(.subheadline, design: .rounded).weight(.medium))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 18)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(gradient)
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .scaleEffect(isPressed ? 0.96 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(DeepPressButtonStyle(isPressed: $isPressed))
    }
}

// MARK: - Cosmic Action Button View
struct CosmicActionButton: View {
    let title: String
    let systemImage: String
    var color: Color = .white
    var action: () -> Void
    var disabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                Text(title)
            }
            .font(.system(.subheadline, design: .rounded).weight(.semibold))
            .foregroundColor(disabled ? color.opacity(0.5) : color)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .fill(color.opacity(disabled ? 0.1 : 0.2))
                    .overlay(
                        Capsule()
                            .stroke(color.opacity(disabled ? 0.2 : 0.3), lineWidth: 1)
                    )
            )
            .contentShape(Capsule())
        }
        .disabled(disabled)
        .buttonStyle(SpringButtonStyle())
    }
}

// MARK: - Delete Button View
struct DeleteButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.system(size: 12, weight: .black))
                .foregroundColor(.white)
                .padding(6)
                .background(
                    Circle()
                        .fill(.black)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                )
                .padding(6)
        }
        .buttonStyle(SpringButtonStyle())
    }
}

// MARK: - Preset Button View
 struct PresetButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(color)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.2), lineWidth: 2)
            )
            .shadow(color: color.opacity(0.4), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
        .help("Set reminder for \(title)")
    }
}

// MARK: - Reminder Preset Buttons View
struct ReminderPresetButtons: View {
    let cosmicGradient: LinearGradient
    let onPresetSelected: (PresetType) -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
            ForEach(PresetType.allCases, id: \.self) { preset in
                CosmicButton(
                    title: preset.title,
                    icon: preset.icon,
                    gradient: cosmicGradient,
                    action: { onPresetSelected(preset) }
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Reminder Action Buttons View
struct ReminderActionButtons: View {
    let cosmicGradient: LinearGradient
    @Binding var reminderDate: Date?
    @Binding var isPresented: Bool
    @Binding var showTimePicker: Bool
    @Binding var showTemplateCreator: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            // Custom Time Button
            Button(action: { showTimePicker = true }) {
                HStack {
                    Image(systemName: "clock.badge")
                    Text("Custom Time")
                }
                .font(.system(.body, design: .rounded).weight(.semibold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(cosmicGradient)
                        .shadow(color: .purple.opacity(0.4), radius: 6, x: 0, y: 3)
                )
            }
            .buttonStyle(SpringButtonStyle())
            
            // Create Template Button
            Button(action: { showTemplateCreator = true }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Create New Template")
                }
                .font(.system(.body, design: .rounded).weight(.semibold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(hex: 0x4ECDC4)) // Nebula palette color
                        .shadow(color: .teal.opacity(0.3), radius: 6, x: 0, y: 3)
                )
            }
            .buttonStyle(SpringButtonStyle())
            
            // Bottom action row
            HStack(spacing: 16) {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(CosmicActionButtonStyle(color: .cyan))
                
                if reminderDate != nil {
                    Button("Remove Reminder") {
                        reminderDate = nil
                        isPresented = false
                    }
                    .buttonStyle(CosmicActionButtonStyle(color: .red))
                }
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Time Picker Action Buttons View
struct TimePickerActionButtonsView: View {
    @Binding var isPresented: Bool
    @Binding var reminderDate: Date?
    let viewModel: CustomTimePickerViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            CosmicActionButton(
                title: "Back",
                systemImage: "arrow.uturn.left",
                color: .teal,
                action: { isPresented = false }
            )
            
            CosmicActionButton(
                title: "Set Reminder",
                systemImage: "bell.fill",
                color: .purple,
                action: {
                    viewModel.setReminder(
                        reminderDateBinding: $reminderDate,
                        isPresentedBinding: $isPresented
                    )
                }
            )
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
}



