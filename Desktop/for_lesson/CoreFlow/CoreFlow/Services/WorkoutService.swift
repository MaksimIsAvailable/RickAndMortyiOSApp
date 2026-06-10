//
//  WorkoutService.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

final class WorkoutService {

    private let workoutRepository: WorkoutRepositoryProtocol
    private let clubRepository: ClubRepositoryProtocol

    init(
        workoutRepository: WorkoutRepositoryProtocol,
        clubRepository: ClubRepositoryProtocol
    ) {
        self.workoutRepository = workoutRepository
        self.clubRepository = clubRepository
    }

    func fetchWorkouts(for sportTypes: [SportType]) async throws -> [Workout] {
        let workouts = try await workoutRepository.fetchWorkouts(for: sportTypes)
        return workouts.sorted { $0.date < $1.date }
    }

    func fetchWorkouts(for clubId: UUID) async throws -> [Workout] {
        let workouts = try await workoutRepository.fetchWorkouts(for: clubId)
        return workouts.sorted { $0.date < $1.date }
    }

    func fetchClub(by id: UUID) async throws -> Club? {
        try await clubRepository.fetchClub(by: id)
    }

    func fetchClubs() async throws -> [Club] {
        try await clubRepository.fetchClubs()
    }
}
