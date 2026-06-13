import SwiftUI

enum TacticCategory: String, CaseIterable, Identifiable {
    case pressureExit = "Salida de presión"
    case highKickIn = "Lateral arriba"
    case lowKickIn = "Lateral abajo"
    case corner = "Córner"
    case freeKick = "Tiro libre"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .pressureExit: return "arrow.up.right"
        case .highKickIn: return "arrow.up.to.line"
        case .lowKickIn: return "arrow.down.to.line"
        case .corner: return "flag.fill"
        case .freeKick: return "scope"
        }
    }
}

enum CourtTokenKind {
    case teammate
    case opponent
    case ball
}

struct CourtToken: Identifiable {
    let id: String
    let label: String
    let kind: CourtTokenKind
    let x: CGFloat
    let y: CGFloat
}

struct TacticPlay: Identifiable {
    let id: String
    let name: String
    let explanation: String
    let tokens: [CourtToken]
}

