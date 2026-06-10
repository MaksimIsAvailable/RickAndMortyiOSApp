//
//  CoreFlowApp.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

@main
struct CoreFlowApp: App {

    @State private var showOnboarding = !OnboardingViewModel.hasCompletedOnboarding()

    var body: some Scene {
        WindowGroup {
            Group {
                if showOnboarding {
                    OnboardingView {
                        showOnboarding = false
                    }
                } else {
                    MainTabView()
                }
            }
            .preferredColorScheme(.dark)
            .background(Color.CF.background)
        }
    }
}
