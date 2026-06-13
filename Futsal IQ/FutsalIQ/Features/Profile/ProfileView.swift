import SwiftUI

struct ProfileView: View {
    @AppStorage(StorageKeys.hasCompletedOnboarding) private var hasCompletedOnboarding = false
    @AppStorage(StorageKeys.position) private var positionValue = PlayerPosition.universal.rawValue
    @AppStorage(StorageKeys.level) private var levelValue = PlayerLevel.beginner.rawValue
    @AppStorage(StorageKeys.improvementGoal) private var goalValue = ImprovementGoal.control.rawValue
    @AppStorage(StorageKeys.trainingsPerWeek) private var trainingsPerWeek = 3
    @AppStorage(StorageKeys.trainedDays) private var trainedDaysValue = ""
    @AppStorage(StorageKeys.trainedWeek) private var trainedWeekValue = ""
    @AppStorage(StorageKeys.appearanceMode) private var appearanceMode = AppearanceMode.dark.rawValue

    @State private var showsResetConfirmation = false

    private var position: PlayerPosition {
        PlayerPosition(rawValue: positionValue) ?? .universal
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ScreenHeader(
                    eyebrow: "Tu juego",
                    title: "Perfil",
                    subtitle: "Una base simple para personalizar tu progreso.",
                    icon: "person.crop.circle.fill"
                )

                profileHero
                playerData
                appearanceSelector
                resetButton
            }
            .padding(20)
            .padding(.bottom, 16)
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
        .confirmationDialog(
            "¿Reiniciar onboarding?",
            isPresented: $showsResetConfirmation,
            titleVisibility: .visible
        ) {
            Button("Reiniciar", role: .destructive) {
                positionValue = PlayerPosition.universal.rawValue
                levelValue = PlayerLevel.beginner.rawValue
                goalValue = ImprovementGoal.control.rawValue
                trainingsPerWeek = 3
                trainedDaysValue = ""
                trainedWeekValue = ""
                hasCompletedOnboarding = false
            }
            Button("Cancelar", role: .cancel) {}
        } message: {
            Text("Podrás elegir nuevamente tu posición, nivel y objetivo.")
        }
    }

    private var profileHero: some View {
        VStack(spacing: 14) {
            Image(systemName: position.icon)
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.black)
                .frame(width: 84, height: 84)
                .background(AppTheme.neon)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))

            VStack(spacing: 4) {
                Text(position.rawValue)
                    .font(.title.bold())
                Text(position.greeting)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(AppTheme.heroGradient)
        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
    }

    private var playerData: some View {
        SportCard(accent: AppTheme.sportBlue) {
            VStack(spacing: 0) {
                ProfileRow(label: "Posición", value: positionValue, icon: position.icon)
                Divider().padding(.vertical, 12)
                ProfileRow(label: "Nivel", value: levelValue, icon: "chart.bar.fill")
                Divider().padding(.vertical, 12)
                ProfileRow(label: "Objetivo", value: goalValue, icon: "scope")
                Divider().padding(.vertical, 12)
                ProfileRow(label: "Entrenamientos", value: "\(trainingsPerWeek) por semana", icon: "calendar")
            }
        }
    }

    private var appearanceSelector: some View {
        SportCard(accent: AppTheme.neon) {
            VStack(alignment: .leading, spacing: 14) {
                SectionTitle(title: "Apariencia", icon: "paintbrush.fill")

                Picker("Apariencia", selection: $appearanceMode) {
                    ForEach(AppearanceMode.allCases) { mode in
                        Label(mode.rawValue, systemImage: mode.icon)
                            .tag(mode.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }

    private var resetButton: some View {
        Button {
            showsResetConfirmation = true
        } label: {
            Label("Reiniciar onboarding", systemImage: "arrow.counterclockwise")
                .font(.headline)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.red.opacity(0.10))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct ProfileRow: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(AppTheme.sportBlue)
                .frame(width: 24)
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline.weight(.semibold))
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
    .preferredColorScheme(.dark)
}
