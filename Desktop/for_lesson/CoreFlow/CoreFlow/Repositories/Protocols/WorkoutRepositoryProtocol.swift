//
//  WorkoutRepositoryProtocol.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

protocol WorkoutRepositoryProtocol {
    func fetchWorkouts() async throws -> [Workout]
    func fetchWorkouts(for sportTypes: [SportType]) async throws -> [Workout]
    func fetchWorkouts(for clubId: UUID) async throws -> [Workout]
}
