//
//  SportSelectorTile.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct SportSelectorTile: View {

    let sport: SportType
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Text(sport.emoji)
                    .font(.title3)
                Text(sport.displayName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(isSelected ? Color.CF.primary : Color.CF.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.CF.primary)
                }
            }
            .padding(.horizontal, 12)
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.CF.primary.opacity(0.15) : Color.CF.surface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.CF.primary : Color.clear, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.15), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}
