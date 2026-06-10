//
//  APIWorkoutRepository.swift
//  CoreFlow
//
//  Created by Maksim on 5/27/26.
//

import Foundation

final class APIWorkoutRepository: WorkoutRepositoryProtocol {

    func fetchWorkouts() async throws -> [Workout] {
        let response = try await APIService.shared.fetchWorkouts()
        return response.map { $0.toWorkout() }
    }

    func fetchWorkouts(for sportTypes: [SportType]) async throws -> [Workout] {
        if sportTypes.count == 1 {
            let response = try await APIService.shared.fetchWorkouts(sportType: sportTypes[0].rawValue)
            return response.map { $0.toWorkout() }
        }
        let response = try await APIService.shared.fetchWorkouts()
        return response.map { $0.toWorkout() }
    }

    func fetchWorkouts(for clubId: UUID) async throws -> [Workout] {
        let response = try await APIService.shared.fetchWorkouts()
        return response.map { $0.toWorkout() }.filter { $0.clubId == clubId }
    }
}
