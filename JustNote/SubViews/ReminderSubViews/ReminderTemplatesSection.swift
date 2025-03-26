//
//  ReminderTemplatesSection.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 18.03.2025.
//

import SwiftUI

struct ReminderTemplatesSection: View {
    let showCustomTemplates: Bool
    let cosmicGradient: LinearGradient
    let customTemplates: [ReminderTemplate]
    let onTemplateSelected: (ReminderTemplate) -> Void
    let onTemplateDeleted: (ReminderTemplate) -> Void
    let colorForTemplate: (ReminderTemplate) -> Color
    
    var body: some View {
        Group {
            if showCustomTemplates {
                VStack(alignment: .leading) {
                    Text("Your Templates")
                        .font(.system(.headline, design: .rounded).weight(.semibold))
                        .foregroundStyle(cosmicGradient)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                    
                    if customTemplates.isEmpty {
                        ContentUnavailableView(
                            "No Templates",
                            systemImage: "clock.badge.questionmark",
                            description: Text("Create custom reminder templates for quick access")
                        )
                        .symbolVariant(.slash)
                        .symbolEffect(.variableColor)
                        .padding()
                    } else {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
                            ForEach(customTemplates) { template in
                                ZStack(alignment: .topTrailing) {
                                    CosmicButton(
                                        title: template.name,
                                        icon: "clock",
                                        gradient: LinearGradient(
                                            colors: [
                                                colorForTemplate(template),
                                                colorForTemplate(template).opacity(0.8)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        action: { onTemplateSelected(template) }
                                    )
                                    
                                    DeleteButton {
                                        onTemplateDeleted(template)
                                    }
                                }
                                .transition(.slide)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}
