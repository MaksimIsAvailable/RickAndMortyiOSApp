//
//  ClubViewModel.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

@MainActor
final class ClubViewModel: ObservableObject {

    @Published var club: Club
    @Published var workouts: [Workout] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let service: WorkoutService

    init(club: Club, service: WorkoutService, workouts: [Workout] = []) {
        self.club = club
        self.service = service
        self.workouts = workouts.filter { $0.clubId == club.id }
    }

    func loadWorkouts() async {
        guard workouts.isEmpty else { return }
        isLoading = true
        do {
            let result = try await service.fetchWorkouts(for: club.id)
            self.workouts = result
            self.isLoading = false
        } catch {
            self.errorMessage = "Не удалось загрузить тренировки"
            self.isLoading = false
        }
    }
}
