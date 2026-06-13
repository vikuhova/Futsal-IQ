import SwiftUI

enum LearningCategory: String, CaseIterable, Identifiable {
    case tips = "Tips"
    case movements = "Movimientos básicos"
    case tactics = "Conceptos tácticos"
    case mindset = "Mentalidad"
    case mistakes = "Errores comunes"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .tips: return "lightbulb.fill"
        case .movements: return "figure.run"
        case .tactics: return "point.3.connected.trianglepath.dotted"
        case .mindset: return "brain"
        case .mistakes: return "exclamationmark.triangle.fill"
        }
    }

    var color: Color {
        switch self {
        case .tips: return AppTheme.neon
        case .movements: return AppTheme.sportBlue
        case .tactics: return .purple
        case .mindset: return .orange
        case .mistakes: return .red
        }
    }
}

struct LearningItem: Identifiable {
    let id: String
    let title: String
    let description: String
    let category: LearningCategory
}
