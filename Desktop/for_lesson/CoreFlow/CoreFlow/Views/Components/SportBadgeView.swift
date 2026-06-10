//
//  SportBadgeView.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct SportBadgeView: View {

    let sport: SportType

    var body: some View {
        Text("\(sport.emoji) \(sport.displayName)")
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private var backgroundColor: Color {
        switch sport {
        case .road: return Color.CF.road
        case .gravel: return Color.CF.gravel
        case .fixedGear: return Color.CF.fixedGear
        case .run: return Color.CF.run
        }
    }

    private var foregroundColor: Color { .white }
}
