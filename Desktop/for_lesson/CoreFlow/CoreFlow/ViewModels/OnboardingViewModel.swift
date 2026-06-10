//
//  OnboardingViewModel.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {

    @Published var selectedSports: Set<SportType> = []

    private let userDefaultsKey = "selectedSports"

    var canProceed: Bool {
        !selectedSports.isEmpty
    }

    func toggle(_ sport: SportType) {
        if selectedSports.contains(sport) {
            selectedSports.remove(sport)
        } else {
            selectedSports.insert(sport)
        }
    }

    func isSelected(_ sport: SportType) -> Bool {
        selectedSports.contains(sport)
    }

    func complete() {
        let raw = selectedSports.map { $0.rawValue }
        UserDefaults.standard.set(raw, forKey: userDefaultsKey)
    }

    static func hasCompletedOnboarding() -> Bool {
        let raw = UserDefaults.standard.stringArray(forKey: "selectedSports") ?? []
        return !raw.isEmpty
    }
}
