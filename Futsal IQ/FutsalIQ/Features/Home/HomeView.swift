import SwiftUI

struct HomeView: View {
    @AppStorage(StorageKeys.position) private var positionValue = PlayerPosition.universal.rawValue
    @AppStorage(StorageKeys.improvementGoal) private var goalValue = ImprovementGoal.control.rawValue
    @AppStorage(StorageKeys.trainingsPerWeek) private var trainingsPerWeek = 3
    @AppStorage(StorageKeys.trainedDays) private var trainedDaysValue = ""
    @AppStorage(StorageKeys.trainedWeek) private var trainedWeekValue = ""

    private var position: PlayerPosition {
        PlayerPosition(rawValue: positionValue) ?? .universal
    }

    private var completedDays: Set<String> {
        Set(trainedDaysValue.split(separator: ",").map(String.init))
    }

    private var progress: Double {
        min(Double(completedDays.count) / Double(max(trainingsPerWeek, 1)), 1)
    }

    private var currentWeekIdentifier: String {
        let calendar = Calendar.current
        let year = calendar.component(.yearForWeekOfYear, from: Date())
        let week = calendar.component(.weekOfYear, from: Date())
        return "\(year)-\(week)"
    }

    private var quote: String {
        let day = Calendar.current.component(.day, from: Date())
        return AppContent.mindsetQuotes[day % AppContent.mindsetQuotes.count]
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                hero
                habitTracker
                dailyTip
                weeklyGoal
                mindset
            }
            .padding(20)
            .padding(.bottom, 16)
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
        .onAppear {
            resetTrackerForNewWeekIfNeeded()
        }
    }

    private var hero: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("HOLA, \(position.rawValue.uppercased())")
                    .font(.caption.weight(.black))
                    .tracking(1.1)
                    .foregroundStyle(AppTheme.neon)

                Text(position.greeting)
                    .font(.title.bold())
                    .fixedSize(horizontal: false, vertical: true)

                CapsuleTag(text: "Foco: \(goalValue)", icon: "scope", color: AppTheme.sportBlue)
            }

            Spacer(minLength: 0)

            Image(systemName: position.icon)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.black)
                .frame(width: 64, height: 64)
                .background(AppTheme.neon)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .rotationEffect(.degrees(3))
        }
        .padding(20)
        .background(AppTheme.heroGradient)
        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(AppTheme.neon.opacity(0.18))
        }
    }

    private var habitTracker: some View {
        SportCard(accent: AppTheme.neon) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    SectionTitle(title: "Semana de entrenamiento", icon: "checkmark.circle.fill")
                    Text("\(completedDays.count)/\(trainingsPerWeek)")
                        .font(.caption.bold())
                        .foregroundStyle(AppTheme.neon)
                }

                HStack(spacing: 6) {
                    ForEach(Weekday.allCases) { day in
                        let isComplete = completedDays.contains(day.rawValue)

                        Button {
                            toggle(day)
                        } label: {
                            VStack(spacing: 7) {
                                Text(day.rawValue)
                                    .font(.caption.weight(.bold))
                                Image(systemName: isComplete ? "checkmark" : "plus")
                                    .font(.caption.weight(.black))
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(isComplete ? .black : .secondary)
                                    .background(isComplete ? AppTheme.neon : Color.secondary.opacity(0.12))
                                    .clipShape(Circle())
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("\(day.rawValue), \(isComplete ? "entrenado" : "sin entrenar")")
                    }
                }
            }
        }
    }

    private var dailyTip: some View {
        SportCard(accent: AppTheme.sportBlue) {
            VStack(alignment: .leading, spacing: 12) {
                SectionTitle(title: "Tip del día", icon: "lightbulb.fill", color: AppTheme.sportBlue)
                Text(position.dailyTip)
                    .font(.body.weight(.medium))
                    .fixedSize(horizontal: false, vertical: true)
                CapsuleTag(text: position.rawValue, icon: position.icon, color: AppTheme.sportBlue)
            }
        }
    }

    private var weeklyGoal: some View {
        SportCard(accent: AppTheme.neon) {
            VStack(alignment: .leading, spacing: 14) {
                SectionTitle(title: "Objetivo semanal", icon: "target")

                HStack(alignment: .firstTextBaseline) {
                    Text("Completar \(trainingsPerWeek) sesiones")
                        .font(.headline)
                    Spacer()
                    Text("\(Int(progress * 100))%")
                        .font(.title3.bold())
                        .foregroundStyle(AppTheme.neon)
                }

                ProgressView(value: progress)
                    .tint(AppTheme.neon)

                Text(progress >= 1 ? "Objetivo cumplido. Mantené la calidad." : "Cada sesión suma cuando tiene una intención clara.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var mindset: some View {
        SportCard(accent: .orange) {
            VStack(alignment: .leading, spacing: 12) {
                SectionTitle(title: "Mentalidad de jugador", icon: "brain", color: .orange)
                Text("“\(quote)”")
                    .font(.title3.weight(.semibold))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func toggle(_ day: Weekday) {
        resetTrackerForNewWeekIfNeeded()
        var updated = completedDays
        if updated.contains(day.rawValue) {
            updated.remove(day.rawValue)
        } else {
            updated.insert(day.rawValue)
        }
        trainedDaysValue = updated.sorted().joined(separator: ",")
    }

    private func resetTrackerForNewWeekIfNeeded() {
        guard trainedWeekValue != currentWeekIdentifier else { return }
        trainedDaysValue = ""
        trainedWeekValue = currentWeekIdentifier
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .preferredColorScheme(.dark)
}
