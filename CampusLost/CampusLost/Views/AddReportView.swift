//
//  AddReportView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI
import SwiftData

struct AddReportView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @StateObject var viewModel: AddReportViewModel
    
    @AppStorage("localUserID") private var localUserID = ""
    @AppStorage("selectedUniversity") private var selectedUniversityRawValue = University.uts.rawValue
    
    private var selectedUniversity: University {
        University(rawValue: selectedUniversityRawValue) ?? .uts
    }

    private var locations: [CampusLocation]{ CampusLocationData.locations(for: selectedUniversity)
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
                }

                Section("Details") {
                    TextField("Description", text: $viewModel.description, axis: .vertical)
                        .lineLimit(4)

                    TextField("Contact info", text: $viewModel.contact)
                        .keyboardType(.emailAddress)
                }

                Section {
                    Button {
                        
                        _ = viewModel.submitReport(modelContext: modelContext, selectedUniversity: selectedUniversity, locations: locations, currentUserID: UserManager.getOrCreateUserID())
                    
                    } label: {
                        Text("Submit Report")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
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
    AddReportView(viewModel: AddReportViewModel())
}
