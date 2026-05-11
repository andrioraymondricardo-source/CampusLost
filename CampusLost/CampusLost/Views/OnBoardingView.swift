//
//  OnBoardingView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

//This is the first screen the user will encountered where they have to choose a university for this singular session.
struct OnBoardingView: View {
    @Binding var hasSelectedSessionUniversity:Bool

    @AppStorage("selectedUniversity") private var selectedUniversity: String = ""

    @State private var chosenUniversity = University.uts.rawValue

    let universities = University.allCases

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
                            Text(university.rawValue)
                                .tag(university.rawValue)
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
                        hasSelectedSessionUniversity = true
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
    OnBoardingView(hasSelectedSessionUniversity: .constant(false))
}
