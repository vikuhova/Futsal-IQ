import Foundation

enum AppContent {
    static let mindsetQuotes = [
        "Jugá simple cuando el partido se vuelva difícil.",
        "La próxima acción importa más que el último error.",
        "Comunicar temprano también es defender.",
        "Escanear antes de recibir te regala tiempo.",
        "La intensidad sirve más cuando tiene intención."
    ]

    static let learningItems: [LearningItem] = [
        LearningItem(
            id: "tip-scan",
            title: "Escaneá antes de recibir",
            description: "Mirá alrededor antes de que llegue el pase para decidir con una ventaja real.",
            category: .tips
        ),
        LearningItem(
            id: "tip-sole",
            title: "Usá la planta con intención",
            description: "La planta ayuda a pausar, proteger y orientar el próximo toque en espacios cortos.",
            category: .tips
        ),
        LearningItem(
            id: "move-control",
            title: "Control orientado",
            description: "Llevá la pelota hacia el espacio libre con el primer toque, no hacia la presión.",
            category: .movements
        ),
        LearningItem(
            id: "move-wall",
            title: "Pared y ruptura",
            description: "Después de pasar, acelerá hacia un espacio diferente para recibir de frente.",
            category: .movements
        ),
        LearningItem(
            id: "tactic-width",
            title: "Amplitud útil",
            description: "Abrir la cancha obliga al rival a recorrer más distancia y crea líneas interiores.",
            category: .tactics
        ),
        LearningItem(
            id: "tactic-balance",
            title: "Equilibrio defensivo",
            description: "Mientras atacan, al menos un jugador debe proteger una posible pérdida.",
            category: .tactics
        ),
        LearningItem(
            id: "mind-next",
            title: "Pensá en la próxima acción",
            description: "Reconocé el error, ajustá una cosa concreta y volvé a entrar al partido.",
            category: .mindset
        ),
        LearningItem(
            id: "mind-communicate",
            title: "Hablá para ayudar",
            description: "Una indicación corta y temprana vale más que un reclamo después de la jugada.",
            category: .mindset
        ),
        LearningItem(
            id: "mistake-ball",
            title: "Mirar solo la pelota",
            description: "Si perdés referencias de rivales y compañeros, reaccionás siempre un segundo tarde.",
            category: .mistakes
        ),
        LearningItem(
            id: "mistake-static",
            title: "Quedarte quieto después del pase",
            description: "Pasar es el inicio de una nueva acción: apoyá, rompé o equilibrá.",
            category: .mistakes
        )
    ]

    static func plays(for category: TacticCategory) -> [TacticPlay] {
        (1...4).map { number in
            TacticPlay(
                id: "\(category.rawValue)-\(number)",
                name: "\(category.rawValue) · Jugada \(number)",
                explanation: explanation(for: category, number: number),
                tokens: tokens(for: category, variant: number)
            )
        }
    }

    private static func explanation(for category: TacticCategory, number: Int) -> String {
        switch category {
        case .pressureExit:
            return number.isMultiple(of: 2)
                ? "El cierre atrae presión y conecta con el ala opuesta para salir por el lado débil."
                : "El arquero suma una línea de pase y el ala baja para liberar espacio a su espalda."
        case .highKickIn:
            return number.isMultiple(of: 2)
                ? "Un bloqueo corto libera al segundo jugador para recibir de frente."
                : "Amague al apoyo cercano y pase firme al jugador que ataca el centro."
        case .lowKickIn:
            return number.isMultiple(of: 2)
                ? "La pelota vuelve atrás para cambiar rápido el lado de ataque."
                : "El receptor fija cerca de la banda y descarga hacia el apoyo interior."
        case .corner:
            return number.isMultiple(of: 2)
                ? "Bloqueo al primer defensor y llegada libre desde el segundo palo."
                : "Pase atrás para un remate frontal con pantalla delante del arquero."
        case .freeKick:
            return number.isMultiple(of: 2)
                ? "Toque corto para mover la barrera y buscar el ángulo contrario."
                : "Amague de remate y pase lateral al compañero mejor perfilado."
        }
    }

    private static func tokens(for category: TacticCategory, variant: Int) -> [CourtToken] {
        let shift = CGFloat(variant - 2) * 0.025

        switch category {
        case .pressureExit:
            return [
                CourtToken(id: "keeper", label: "A", kind: .teammate, x: 0.50, y: 0.88),
                CourtToken(id: "close", label: "C", kind: .teammate, x: 0.28 + shift, y: 0.70),
                CourtToken(id: "wing1", label: "1", kind: .teammate, x: 0.75, y: 0.62 - shift),
                CourtToken(id: "wing2", label: "2", kind: .teammate, x: 0.20, y: 0.40),
                CourtToken(id: "pivot", label: "P", kind: .teammate, x: 0.62, y: 0.28),
                CourtToken(id: "rival1", label: "", kind: .opponent, x: 0.42, y: 0.60),
                CourtToken(id: "rival2", label: "", kind: .opponent, x: 0.66, y: 0.48),
                CourtToken(id: "ball", label: "", kind: .ball, x: 0.47, y: 0.84)
            ]
        case .highKickIn:
            return [
                CourtToken(id: "taker", label: "1", kind: .teammate, x: 0.90, y: 0.30),
                CourtToken(id: "support", label: "2", kind: .teammate, x: 0.72, y: 0.43 + shift),
                CourtToken(id: "close", label: "C", kind: .teammate, x: 0.42, y: 0.60),
                CourtToken(id: "pivot", label: "P", kind: .teammate, x: 0.48 + shift, y: 0.18),
                CourtToken(id: "rival1", label: "", kind: .opponent, x: 0.70, y: 0.29),
                CourtToken(id: "rival2", label: "", kind: .opponent, x: 0.46, y: 0.29),
                CourtToken(id: "ball", label: "", kind: .ball, x: 0.94, y: 0.30)
            ]
        case .lowKickIn:
            return [
                CourtToken(id: "taker", label: "1", kind: .teammate, x: 0.10, y: 0.68),
                CourtToken(id: "support", label: "2", kind: .teammate, x: 0.28, y: 0.56 + shift),
                CourtToken(id: "close", label: "C", kind: .teammate, x: 0.55, y: 0.72),
                CourtToken(id: "pivot", label: "P", kind: .teammate, x: 0.54 - shift, y: 0.35),
                CourtToken(id: "rival1", label: "", kind: .opponent, x: 0.27, y: 0.66),
                CourtToken(id: "rival2", label: "", kind: .opponent, x: 0.49, y: 0.52),
                CourtToken(id: "ball", label: "", kind: .ball, x: 0.06, y: 0.68)
            ]
        case .corner:
            return [
                CourtToken(id: "taker", label: "1", kind: .teammate, x: 0.91, y: 0.10),
                CourtToken(id: "near", label: "2", kind: .teammate, x: 0.70 + shift, y: 0.18),
                CourtToken(id: "far", label: "P", kind: .teammate, x: 0.28, y: 0.17 + shift),
                CourtToken(id: "shot", label: "C", kind: .teammate, x: 0.52, y: 0.34),
                CourtToken(id: "rival1", label: "", kind: .opponent, x: 0.60, y: 0.15),
                CourtToken(id: "rival2", label: "", kind: .opponent, x: 0.38, y: 0.14),
                CourtToken(id: "ball", label: "", kind: .ball, x: 0.94, y: 0.08)
            ]
        case .freeKick:
            return [
                CourtToken(id: "taker", label: "1", kind: .teammate, x: 0.47, y: 0.38),
                CourtToken(id: "option", label: "2", kind: .teammate, x: 0.68 + shift, y: 0.38),
                CourtToken(id: "pivot", label: "P", kind: .teammate, x: 0.30, y: 0.20),
                CourtToken(id: "close", label: "C", kind: .teammate, x: 0.50, y: 0.65),
                CourtToken(id: "rival1", label: "", kind: .opponent, x: 0.42, y: 0.28),
                CourtToken(id: "rival2", label: "", kind: .opponent, x: 0.52, y: 0.27),
                CourtToken(id: "rival3", label: "", kind: .opponent, x: 0.62, y: 0.28),
                CourtToken(id: "ball", label: "", kind: .ball, x: 0.50, y: 0.36)
            ]
        }
    }
}

