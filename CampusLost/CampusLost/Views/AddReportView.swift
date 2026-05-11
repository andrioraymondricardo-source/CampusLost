//
//  AddReportView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI
import SwiftData

struct AddReportView: View {

    // allows this view to save new reports into SwiftData
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var reportType: ReportType = .lost
    @State private var category: ItemCategory = .electronics
    @State private var locationName = "UTS Library"
    @State private var description = ""
    @State private var contact = ""

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccess = false

    // local user id used for report ownership in the MVP
    @AppStorage("localUserID") private var localUserID: String = UUID().uuidString

    var body: some View {

        NavigationStack {

            ZStack {

                AppTheme.background
                    .ignoresSafeArea()

                ScrollView {

                    VStack(alignment: .leading, spacing: 24) {

                        Text("Add Report")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        VStack(alignment: .leading, spacing: 12) {

                            Text("Item Information")
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            VStack(spacing: 0) {

                                TextField("Item title", text: $title)
                                    .padding()

                                Divider()

                                Picker("Report Type", selection: $reportType) {
                                    ForEach(ReportType.allCases) { type in
                                        Text(type.rawValue)
                                            .tag(type)
                                    }
                                }
                                .padding()

                                Divider()

                                Picker("Category", selection: $category) {
                                    ForEach(ItemCategory.allCases) { category in
                                        Text(category.rawValue)
                                            .tag(category)
                                    }
                                }
                                .padding()

                                Divider()

                                Picker("Location", selection: $locationName) {
                                    ForEach(CampusLocationData.locations) { location in
                                        Text(location.name)
                                            .tag(location.name)
                                    }
                                }
                                .padding()
                            }
                            .background(.white)
                            .cornerRadius(AppTheme.cornerRadius)
                        }

                        VStack(alignment: .leading, spacing: 12) {

                            Text("Details")
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            VStack(spacing: 0) {

                                TextField("Description", text: $description, axis: .vertical)
                                    .lineLimit(4)
                                    .padding()

                                Divider()

                                TextField("Contact info", text: $contact)
                                    .keyboardType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .padding()
                            }
                            .background(.white)
                            .cornerRadius(AppTheme.cornerRadius)
                        }

                        Button {
                            submitReport()
                        } label: {
                            Text("Submit Report")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.primary)
                                .cornerRadius(AppTheme.cornerRadius)
                        }
                    }
                    .padding()
                }
            }
            .alert("Missing Information", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .alert("Report Added", isPresented: $showSuccess) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your report has been added to the Home list.")
            }
        }
    }

    // validates form input and saves the report into SwiftData
    func submitReport() {

        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter the item title."
            showAlert = true
            return
        }

        if description.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter a description."
            showAlert = true
            return
        }

        if contact.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Please enter contact information."
            showAlert = true
            return
        }

        let selectedLocation =
        CampusLocationData.locations.first { location in
            location.name == locationName
        } ?? CampusLocationData.locations[0]

        let newItem = LostFoundItem(
            title: title,
            itemDescription: description,
            reportType: reportType,
            category: category,
            status: .active,
            university: .uts,
            locationName: selectedLocation.name,
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
            dateReported: Date(),
            contact: contact,
            createdByUserID: localUserID
        )

        modelContext.insert(newItem)

        title = ""
        reportType = .lost
        category = .electronics
        locationName = "UTS Library"
        description = ""
        contact = ""

        showSuccess = true
    }
}

#Preview {
    AddReportView()
        .modelContainer(for: LostFoundItem.self, inMemory: true)
}
