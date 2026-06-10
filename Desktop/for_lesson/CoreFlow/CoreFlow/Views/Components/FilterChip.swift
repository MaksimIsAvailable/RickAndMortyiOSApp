//
//  FilterChip.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import SwiftUI

struct FilterChip: View {

    let title: String
    let isSelected: Bool
    var accentColor: Color = Color.CF.primary
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? accentColor : Color.CF.surfaceSecondary)
                .foregroundStyle(isSelected ? .white : Color.CF.textPrimary)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.clear : Color.CF.textTertiary.opacity(0.5), lineWidth: 0.5)
                )
                .animation(.easeInOut(duration: 0.15), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}
