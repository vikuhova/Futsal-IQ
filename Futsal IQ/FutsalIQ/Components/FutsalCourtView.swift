import SwiftUI

struct FutsalCourtView: View {
    let tokens: [CourtToken]

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size

            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(AppTheme.pitch)

                courtLines(in: size)

                ForEach(tokens) { token in
                    CourtTokenView(token: token)
                        .position(x: token.x * size.width, y: token.y * size.height)
                }
            }
        }
        .aspectRatio(0.68, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(AppTheme.pitchLine, lineWidth: 2)
        }
        .shadow(color: AppTheme.neon.opacity(0.12), radius: 20, y: 10)
        .accessibilityLabel("Tablero de futsal con fichas de la jugada")
    }

    @ViewBuilder
    private func courtLines(in size: CGSize) -> some View {
        let line = AppTheme.pitchLine

        Path { path in
            path.move(to: CGPoint(x: 0, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width, y: size.height / 2))
        }
        .stroke(line, lineWidth: 1.5)

        Circle()
            .stroke(line, lineWidth: 1.5)
            .frame(width: size.width * 0.28, height: size.width * 0.28)

        VStack {
            RoundedRectangle(cornerRadius: size.width * 0.12)
                .stroke(line, lineWidth: 1.5)
                .frame(width: size.width * 0.62, height: size.height * 0.16)
                .offset(y: -size.height * 0.08)

            Spacer()

            RoundedRectangle(cornerRadius: size.width * 0.12)
                .stroke(line, lineWidth: 1.5)
                .frame(width: size.width * 0.62, height: size.height * 0.16)
                .offset(y: size.height * 0.08)
        }

        VStack {
            Rectangle()
                .stroke(line, lineWidth: 1.5)
                .frame(width: size.width * 0.30, height: 9)
                .offset(y: -5)

            Spacer()

            Rectangle()
                .stroke(line, lineWidth: 1.5)
                .frame(width: size.width * 0.30, height: 9)
                .offset(y: 5)
        }
    }
}

private struct CourtTokenView: View {
    let token: CourtToken

    var body: some View {
        ZStack {
            Circle()
                .fill(fillColor)
                .frame(width: token.kind == .ball ? 15 : 31, height: token.kind == .ball ? 15 : 31)
                .overlay {
                    Circle()
                        .stroke(.white.opacity(0.9), lineWidth: token.kind == .ball ? 1 : 2)
                }
                .shadow(color: .black.opacity(0.3), radius: 4, y: 2)

            if !token.label.isEmpty {
                Text(token.label)
                    .font(.caption2.bold())
                    .foregroundStyle(token.kind == .teammate ? .black : .white)
            }
        }
    }

    private var fillColor: Color {
        switch token.kind {
        case .teammate: return AppTheme.neon
        case .opponent: return .red
        case .ball: return .white
        }
    }
}

