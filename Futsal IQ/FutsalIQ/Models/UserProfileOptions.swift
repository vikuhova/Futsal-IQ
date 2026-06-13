import SwiftUI

enum PlayerPosition: String, CaseIterable, Identifiable {
    case cierre = "Cierre"
    case ala = "Ala"
    case pivot = "Pivot"
    case arquero = "Arquero"
    case universal = "Universal"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .cierre: return "shield.fill"
        case .ala: return "wind"
        case .pivot: return "scope"
        case .arquero: return "hand.raised.fill"
        case .universal: return "arrow.triangle.2.circlepath"
        }
    }

    var greeting: String {
        switch self {
        case .cierre: return "Ordená el juego desde atrás"
        case .ala: return "Dale amplitud y ritmo al equipo"
        case .pivot: return "Fijá, girá y hacé jugar"
        case .arquero: return "Leé el juego antes que nadie"
        case .universal: return "Impactá donde el equipo te necesite"
        }
    }

    var dailyTip: String {
        switch self {
        case .cierre:
            return "Antes de recibir, mirá ambos hombros. Tu primera decisión ordena al resto."
        case .ala:
            return "Recibí perfilado hacia adelante. Un buen control puede eliminar una línea."
        case .pivot:
            return "Usá el cuerpo para proteger, pero decidí antes del contacto: giro o descarga."
        case .arquero:
            return "En salida, ofrecé siempre un ángulo nuevo después de cada pase."
        case .universal:
            return "Escaneá dónde falta equilibrio y ocupá ese espacio antes de pedir la pelota."
        }
    }
}

enum PlayerLevel: String, CaseIterable, Identifiable {
    case beginner = "Principiante"
    case intermediate = "Intermedio"
    case competitive = "Competitivo"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .beginner: return "figure.walk"
        case .intermediate: return "figure.run"
        case .competitive: return "bolt.fill"
        }
    }
}

enum ImprovementGoal: String, CaseIterable, Identifiable {
    case passing = "Pase"
    case control = "Control"
    case defending = "Marca"
    case finishing = "Definición"
    case mindset = "Mentalidad"
    case fitness = "Físico"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .passing: return "arrow.left.arrow.right"
        case .control: return "circle.dotted"
        case .defending: return "person.2.fill"
        case .finishing: return "target"
        case .mindset: return "brain"
        case .fitness: return "figure.strengthtraining.traditional"
        }
    }
}

enum Weekday: String, CaseIterable, Identifiable {
    case monday = "L"
    case tuesday = "M"
    case wednesday = "X"
    case thursday = "J"
    case friday = "V"
    case saturday = "S"
    case sunday = "D"

    var id: String { rawValue }
}
