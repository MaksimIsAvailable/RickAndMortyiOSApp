//
//  MockWorkoutRepository.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

final class MockWorkoutRepository: WorkoutRepositoryProtocol {

    func fetchWorkouts() async throws -> [Workout] {
        MockData.workouts
    }

    func fetchWorkouts(for sportTypes: [SportType]) async throws -> [Workout] {
        guard !sportTypes.isEmpty else { return MockData.workouts }
        return MockData.workouts.filter { sportTypes.contains($0.sportType) }
    }

    func fetchWorkouts(for clubId: UUID) async throws -> [Workout] {
        MockData.workouts.filter { $0.clubId == clubId }
    }
}
