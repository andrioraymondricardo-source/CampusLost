//
//  AddReportView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct AddReportView: View {

    @State private var title = ""
    @State private var reportType = "Lost"
    @State private var category = "Electronics"
    @State private var location = "UTS Library"
    @State private var description = ""
    @State private var contact = ""

    let reportTypes = ["Lost", "Found"]
    let categories = [
        "Electronics",
        "Cards/ID",
        "Clothing",
        "Books/Stationery",
        "Bottles",
        "Keys",
        "Bags",
        "Other"
    ]

    let locations = [
        "UTS Library",
        "Building 1",
        "Building 2",
        "Building 10",
        "Building 11",
        "Alumni Green",
        "Central Station area"
    ]

    var body: some View {

        NavigationStack {

            Form {

                Section("Item Information") {

                    TextField("Item title", text: $title)

                    Picker("Report Type", selection: $reportType) {
                        ForEach(reportTypes, id: \.self) { type in
                            Text(type)
                        }
                    }

                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }

                    Picker("Location", selection: $location) {
                        ForEach(locations, id: \.self) { location in
                            Text(location)
                        }
                    }
                }

                Section("Details") {
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(4)

                    TextField("Contact info", text: $contact)
                        .keyboardType(.emailAddress)
                }

                Section {
                    Button {
                        title = ""
                        reportType = "Lost"
                        category = "Electronics"
                        location = "UTS Library"
                        description = ""
                        contact = ""
                    } label: {
                        Text("Submit Report")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Add Report")
        }
    }
}

#Preview {
    AddReportView()
}
