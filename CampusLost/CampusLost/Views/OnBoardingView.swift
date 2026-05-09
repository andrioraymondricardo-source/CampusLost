//
//  OnBoardingView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct OnBoardingView: View {

    @AppStorage("selectedUniversity") private var selectedUniversity: String = ""

    @State private var chosenUniversity = "University of Technology Sydney"

    let universities = [
        "University of Technology Sydney",
        "University of Sydney",
        "UNSW Sydney"
    ]

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    AppTheme.primary.opacity(0.25),
                    AppTheme.background
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {

                Spacer()

                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: 90))
                    .foregroundStyle(AppTheme.primary)

                Text("CampusLost")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("A campus lost-and-found app for reporting, searching, and recovering lost items.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Choose your university")
                        .font(.headline)

                    Picker("University", selection: $chosenUniversity) {
                        ForEach(universities, id: \.self) { university in
                            Text(university)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white)
                    .cornerRadius(AppTheme.cornerRadius)
                }

                Button {
                    selectedUniversity = chosenUniversity
                } label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.primary)
                        .cornerRadius(AppTheme.cornerRadius)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    OnBoardingView()
}
