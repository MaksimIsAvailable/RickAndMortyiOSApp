//
//  WorkoutCardView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct WorkoutCardView: View {

    let workout: Workout
    let club: Club?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                SportBadgeView(sport: workout.sportType)
                Spacer()
                if let club {
                    Text(club.shortCity)
                        .font(.caption)
                        .foregroundStyle(Color.CF.textSecondary)
                }
                Text(workout.date.formatted(.dateTime.day().month().locale(Locale(identifier: "ru_RU"))))
                    .font(.caption)
                    .foregroundStyle(Color.CF.textSecondary)
            }

            Text(workout.title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.CF.textPrimary)

            HStack(spacing: 14) {
                if let distance = workout.distanceKm {
                    Label("\(Int(distance)) км", systemImage: "arrow.triangle.swap")
                }
                Label(workout.meetingTime, systemImage: "clock")
                if let club {
                    Label(club.name, systemImage: "person.3")
                }
            }
            .font(.caption)
            .foregroundStyle(Color.CF.textSecondary)
            .lineLimit(1)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.CF.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

private extension Label where Title == Text, Icon == Image {
    init(_ date: Date, systemImage: String) {
        self.init(date.formatted(date: .omitted, time: .shortened), systemImage: systemImage)
    }
}
