//
//  OnboardingView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct OnboardingView: View {

    @StateObject private var viewModel = OnboardingViewModel()
    var onComplete: () -> Void

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Hero
            VStack(alignment: .leading, spacing: 8) {
                Text("Выбери виды спорта")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Покажем заезды и тренировки\nкоторые тебе интересны")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineSpacing(4)
            }
            .padding(.horizontal, 24)
            .padding(.top, 48)
            .padding(.bottom, 32)

            // Сетка видов спорта
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(SportType.allCases) { sport in
                    SportSelectorTile(
                        sport: sport,
                        isSelected: viewModel.isSelected(sport)
                    ) {
                        viewModel.toggle(sport)
                    }
                }
            }
            .padding(.horizontal, 16)

            Spacer()

            // Кнопка
            Button {
                viewModel.complete()
                onComplete()
            } label: {
                Text("Готово")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(viewModel.canProceed ? Color.CF.primary : Color.CF.surfaceSecondary)
                    .foregroundStyle(viewModel.canProceed ? .white : .secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .disabled(!viewModel.canProceed)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
            .animation(.easeInOut(duration: 0.2), value: viewModel.canProceed)
        }
    }
}
