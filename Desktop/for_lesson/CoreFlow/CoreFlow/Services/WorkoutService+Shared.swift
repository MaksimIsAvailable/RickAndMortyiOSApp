//
//  WorkoutService+Shared.swift
//  CoreFlow
//
//  Created by Maksim on 6/1/26.
//

import Foundation

extension WorkoutService {
    static let shared = WorkoutService(
        workoutRepository: APIWorkoutRepository(),
        clubRepository: APIClubRepository()
    )
}
