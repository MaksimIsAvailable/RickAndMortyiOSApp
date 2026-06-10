//
//  Models.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation
import SwiftUI

enum SportType: String, CaseIterable, Codable, Identifiable {
    case road = "road"
    case gravel = "gravel"
    case fixedGear = "fixed_gear"
    case run = "run"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .road: return "Road"
        case .gravel: return "Gravel"
        case .fixedGear: return "Fixed Gear"
        case .run: return "Run"
        }
    }

    var emoji: String {
        switch self {
        case .road: return "🚴"
        case .gravel: return "🚵"
        case .fixedGear: return "⚙️"
        case .run: return "🏃"
        }
    }

    var accentColor: Color {
        switch self {
        case .road: return Color.CF.road
        case .gravel: return Color.CF.gravel
        case .fixedGear: return Color.CF.fixedGear
        case .run: return Color.CF.run
        }
    }
}

struct Club: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var city: String
    var sportTypes: [SportType]
    var description: String?
    var telegramURL: String
    var telegramUsername: String
    var initials: String { String(name.prefix(2)).uppercased() }
    var shortCity: String {
        switch city {
        case "Санкт-Петербург": return "СПб"
        case "Москва": return "Мск"
        default: return city
        }
    }
}

struct Workout: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var date: Date
    var meetingTime: Date
    var startTime: Date
    var location: String
    var distanceKm: Double?
    var elevationM: Int?
    var surfaceMix: String?        // "грунт/асфальт 40/60%"
    var paceDescription: String?   // "25-27 км/ч на грунтах"
    var requirements: String?      // "шлем, мультиспид"
    var description: String
    var routeURL: String?
    var telegramPostURL: String
    var sportType: SportType
    var clubId: UUID
    var posterURL: String?
}
