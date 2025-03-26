//
//  RemindPickerView.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 02.02.2025.
//


import SwiftUI
import SwiftData

// MARK: - Reminder Input View
struct ReminderInputView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var reminderDate: Date?
    @Binding var isPresented: Bool
    @StateObject private var viewModel: ReminderInputViewModel
    
    @Query(sort: \ReminderTemplate.name, animation: .default)
    private var customTemplates: [ReminderTemplate]
    
    init(reminderDate: Binding<Date?>, isPresented: Binding<Bool>, modelContext: ModelContext) {
        self._reminderDate = reminderDate
        self._isPresented = isPresented
        self._viewModel = StateObject(wrappedValue: ReminderInputViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            headerSection
            ScrollView { contentSection }
        }
        .sheet(isPresented: $viewModel.showTimePicker) {
            CustomTimePicker(reminderDate: $reminderDate, isPresented: $viewModel.showTimePicker)
        }
        .sheet(isPresented: $viewModel.showTemplateCreator) {
            TemplateCreatorView(isPresented: $viewModel.showTemplateCreator) {
                viewModel.showCustomTemplates = true
                viewModel.refreshTemplates()
            }
        }
    }
    
    // MARK: - View Components
      private var headerSection: some View {
          ReminderHeaderSection(cosmicGradient: CosmicGradient.main)
      }
      
      private var contentSection: some View {
          VStack(spacing: 20) {
              presetButtons
              customTemplatesSection
              actionButtons
          }
          .padding(.vertical)
      }
      
      private var presetButtons: some View {
          ReminderPresetButtons(
              cosmicGradient: CosmicGradient.main,
              onPresetSelected: { preset in
                  viewModel.handlePreset(preset, reminderDateBinding: $reminderDate, isPresentedBinding: $isPresented)
              }
          )
      }
      
      private var customTemplatesSection: some View {
          ReminderTemplatesSection(
              showCustomTemplates: viewModel.showCustomTemplates,
              cosmicGradient: CosmicGradient.main,
              customTemplates: customTemplates,
              onTemplateSelected: { template in
                  viewModel.setReminder(
                      minutes: template.minutes,
                      reminderDateBinding: $reminderDate,
                      isPresentedBinding: $isPresented
                  )
              },
              onTemplateDeleted: { template in
                  viewModel.deleteTemplate(template)
              },
              colorForTemplate: { template in
                  viewModel.colorForTemplate(template, nebulaPalette: CosmicGradient.nebulaPalette)
              }
          )
      }
      
      private var actionButtons: some View {
          ReminderActionButtons(
              cosmicGradient: CosmicGradient.main,
              reminderDate: $reminderDate,
              isPresented: $isPresented,
              showTimePicker: $viewModel.showTimePicker,
              showTemplateCreator: $viewModel.showTemplateCreator
          )
      }
  }
