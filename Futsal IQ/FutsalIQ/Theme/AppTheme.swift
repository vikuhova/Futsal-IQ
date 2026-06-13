import SwiftUI
import UIKit

enum AppTheme {
    static let neon = Color(red: 0.45, green: 1.00, blue: 0.36)
    static let sportBlue = Color(red: 0.20, green: 0.64, blue: 1.00)
    static let pitch = Color(red: 0.05, green: 0.34, blue: 0.24)
    static let pitchLine = Color.white.opacity(0.82)
    static let card = Color(uiColor: .secondarySystemBackground)
    static let background = Color(uiColor: .systemBackground)

    static let heroGradient = LinearGradient(
        colors: [
            Color(red: 0.04, green: 0.18, blue: 0.15),
            Color(red: 0.05, green: 0.09, blue: 0.15)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

enum AppearanceMode: String, CaseIterable, Identifiable {
    case dark = "Oscuro"
    case light = "Claro"
    case system = "Sistema"

    var id: String { rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .dark: return .dark
        case .light: return .light
        case .system: return nil
        }
    }

    var icon: String {
        switch self {
        case .dark: return "moon.fill"
        case .light: return "sun.max.fill"
        case .system: return "circle.lefthalf.filled"
        }
    }
}

enum StorageKeys {
    static let hasCompletedOnboarding = "hasCompletedOnboarding"
    static let position = "playerPosition"
    static let level = "playerLevel"
    static let improvementGoal = "improvementGoal"
    static let trainingsPerWeek = "trainingsPerWeek"
    static let trainedDays = "trainedDays"
    static let trainedWeek = "trainedWeek"
    static let appearanceMode = "appearanceMode"
}
