//
//  AddReportView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct AddReportView: View {
    
    @Binding var selectedTab: AppTab
    
    @StateObject var viewModel = AddReportViewModel()
    
    @AppStorage("localUserID") private var localUserID = ""
    @AppStorage("selectedUniversity") private var selectedUniversityRawValue = University.uts.rawValue
    
    private var selectedUniversity: University {
        University(rawValue: selectedUniversityRawValue) ?? .uts
    }

    private var locations: [CampusLocation]{ CampusLocationData.locations(for: selectedUniversity)
    }
    
    private var selectedPresetLocation: CampusLocation? {
        locations.first {$0.name == viewModel.location}
    }

    var body: some View {

        NavigationStack {

            Form {

                Section("Item Information") {

                    TextField("Item title", text: $viewModel.title)

                    Picker("Report Type", selection: $viewModel.reportType) {
                        ForEach(ReportType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }

                    Picker("Category", selection: $viewModel.category) {
                        ForEach(ItemCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }

                    Picker("Location", selection: $viewModel.location) {
                        ForEach(locations, id: \.self) { location in
                            Text(location.name)
                                .tag(location.name)
                        }
                    }
                    .onChange(of: viewModel.location) {_, _ in
                        viewModel.selectedLatitude = nil
                        viewModel.selectedLongitude = nil
                    }
                }

                Section("Details") {
                    TextField("Description", text: $viewModel.description, axis: .vertical)
                        .lineLimit(4)

                    TextField("Contact info", text: $viewModel.contact)
                        .keyboardType(.emailAddress)
                }
                
                Section {
                    if let selectedPresetLocation {
                        NavigationLink {
                            ReportLocationPickerView(
                                viewModel: viewModel,
                                startingLocation: selectedPresetLocation
                            )
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Set Location")
                                        .fontWeight(.semibold)

                                    if viewModel.hasSelectedMapLocation {
                                        Text("Exact map location selected")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    } else {
                                        Text("Required before submitting")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }

                                Spacer()

                                Image(
                                    systemName: viewModel.hasSelectedMapLocation
                                    ? "checkmark.circle.fill"
                                    : "mappin.circle"
                                )
                                .foregroundStyle(
                                    viewModel.hasSelectedMapLocation
                                    ? .green
                                    : AppTheme.primary
                                )
                            }
                        }
                    } else {
                        Text("Please select a campus location first.")
                            .foregroundStyle(.secondary)
                    }
                }

                Section {
                    Button {
                        
                        let didSave = viewModel.submitReport(selectedUniversity: selectedUniversity, locations: locations)
                        
                        if didSave {
                            viewModel.clearForm(locations: locations)
                            selectedTab = .home
                        }
                    
                    } label: {
                        Text("Submit Report")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(!viewModel.hasSelectedMapLocation)
                    .opacity(viewModel.hasSelectedMapLocation ? 1 : 0.5)
                }
            }
            .navigationTitle("Add Report")
            .onAppear {
                viewModel.fillLocation(locations: locations)
            }
        }
    }
    
   
    
}

#Preview {
    AddReportView(selectedTab: .constant(.add))
}

