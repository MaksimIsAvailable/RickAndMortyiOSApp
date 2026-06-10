//
//  APIModels.swift
//  CoreFlow
//
//  Created by Maksim on 5/27/26.
//

import Foundation

struct WorkoutResponse: Codable {
    let id: UUID
    let title: String
    let date: Date
    let meetingTime: Date
    let startTime: Date
    let location: String
    let distanceKm: Double?
    let elevationM: Int?
    let surfaceMix: String?
    let paceDescription: String?
    let requirements: String?
    let description: String?
    let routeUrl: String?
    let telegramPostUrl: String
    let sportType: String
    let posterUrl: String?
    let clubId: UUID
    let club: ClubResponse
}

struct ClubResponse: Codable {
    let id: UUID
    let name: String
    let city: String
    let sportTypes: [String]
    let description: String?
    let telegramUrl: String
    let telegramUsername: String
}

extension WorkoutResponse {
    func toWorkout() -> Workout {
        Workout(
            id: id,
            title: title,
            date: date,
            meetingTime: meetingTime,
            startTime: startTime,
            location: location,
            distanceKm: distanceKm,
            elevationM: elevationM,
            surfaceMix: surfaceMix,
            paceDescription: paceDescription,
            requirements: requirements,
            description: description ?? "",
            routeURL: routeUrl,
            telegramPostURL: telegramPostUrl,
            sportType: SportType(rawValue: sportType) ?? .road,
            clubId: clubId,
            posterURL: posterUrl
        )
    }
}

extension ClubResponse {
    func toClub() -> Club {
        Club(
            id: id,
            name: name,
            city: city,
            sportTypes: sportTypes.compactMap { SportType(rawValue: $0) },
            description: description,
            telegramURL: telegramUrl,
            telegramUsername: telegramUsername
        )
    }
}
