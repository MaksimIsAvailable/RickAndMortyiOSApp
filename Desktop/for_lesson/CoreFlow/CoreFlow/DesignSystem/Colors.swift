//
//  Colors.swift
//  CoreFlow
//
//  Created by Maksim on 5/19/26.
//

import SwiftUI

extension Color {
    enum CF {
        static let primary = Color(hex: "#7B5EA7")
        static let secondary = Color(hex: "#00A88A")
        static let background = Color(hex: "#1C1C1E")
        static let surface = Color(hex: "#2C2C2E")
        static let surfaceSecondary = Color(hex: "#3A3A3C")
        static let textPrimary = Color(hex: "#F2F2F7")
        static let textSecondary = Color(hex: "#AEAEB2")
        static let textTertiary = Color(hex: "#636366")
        static let run = Color(hex: "#34D399")
        static let road = Color(hex: "#5B9CF6")
        static let gravel = Color(hex: "#F97B6B")
        static let fixedGear = Color(hex: "#94A3B8")
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
