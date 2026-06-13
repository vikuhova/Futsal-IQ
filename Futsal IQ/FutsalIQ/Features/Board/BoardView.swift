import SwiftUI

struct BoardView: View {
    @State private var selectedCategory = TacticCategory.pressureExit
    @State private var selectedPlayIndex = 0

    private var plays: [TacticPlay] {
        AppContent.plays(for: selectedCategory)
    }

    private var selectedPlay: TacticPlay {
        plays[selectedPlayIndex]
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                ScreenHeader(
                    eyebrow: "Sala táctica",
                    title: "Tablero",
                    subtitle: "Entendé la idea antes de mover rápido.",
                    icon: "sportscourt.fill"
                )

                categoryPicker
                playPicker

                FutsalCourtView(tokens: selectedPlay.tokens)

                SportCard(accent: AppTheme.sportBlue) {
                    VStack(alignment: .leading, spacing: 10) {
                        CapsuleTag(text: selectedCategory.rawValue, icon: selectedCategory.icon, color: AppTheme.sportBlue)
                        Text(selectedPlay.name)
                            .font(.title3.bold())
                        Text(selectedPlay.explanation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(20)
            .padding(.bottom, 16)
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
        .onChange(of: selectedCategory) { _ in
            selectedPlayIndex = 0
        }
    }

    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 9) {
                ForEach(TacticCategory.allCases) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Label(category.rawValue, systemImage: category.icon)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(selectedCategory == category ? .black : Color.primary)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 10)
                            .background(selectedCategory == category ? AppTheme.neon : AppTheme.card)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var playPicker: some View {
        HStack(spacing: 8) {
            ForEach(Array(plays.indices), id: \.self) { index in
                Button("Jugada \(index + 1)") {
                    selectedPlayIndex = index
                }
                .font(.caption.weight(.bold))
                .foregroundStyle(selectedPlayIndex == index ? AppTheme.neon : .secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(selectedPlayIndex == index ? AppTheme.neon.opacity(0.12) : AppTheme.card)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        BoardView()
    }
    .preferredColorScheme(.dark)
}

