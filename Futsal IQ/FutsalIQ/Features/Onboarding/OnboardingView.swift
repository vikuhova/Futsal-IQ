import SwiftUI

struct OnboardingView: View {
    @AppStorage(StorageKeys.hasCompletedOnboarding) private var hasCompletedOnboarding = false
    @AppStorage(StorageKeys.position) private var position = PlayerPosition.universal.rawValue
    @AppStorage(StorageKeys.level) private var level = PlayerLevel.beginner.rawValue
    @AppStorage(StorageKeys.improvementGoal) private var improvementGoal = ImprovementGoal.control.rawValue
    @AppStorage(StorageKeys.trainingsPerWeek) private var trainingsPerWeek = 3

    @State private var step = 0

    private let titles = [
        "¿Qué posición jugás?",
        "¿Cuál es tu nivel?",
        "¿Qué querés mejorar?",
        "¿Cuántas veces entrenás?"
    ]

    private let subtitles = [
        "Vamos a adaptar los consejos a tu rol.",
        "Así mantenemos los contenidos en el punto justo.",
        "Elegí tu prioridad principal para esta etapa.",
        "Definí una meta semanal realista."
    ]

    var body: some View {
        ZStack {
            AppTheme.heroGradient
                .ignoresSafeArea()

            VStack(spacing: 0) {
                onboardingHeader

                TabView(selection: $step) {
                    positionStep.tag(0)
                    levelStep.tag(1)
                    goalStep.tag(2)
                    frequencyStep.tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                navigationButtons
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .animation(.easeInOut(duration: 0.22), value: step)
    }

    private var onboardingHeader: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Label("FUTSAL IQ", systemImage: "bolt.fill")
                    .font(.headline.weight(.black))
                    .foregroundStyle(AppTheme.neon)

                Spacer()

                Text("\(step + 1) / 4")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 7) {
                ForEach(0..<4, id: \.self) { index in
                    Capsule()
                        .fill(index <= step ? AppTheme.neon : Color.white.opacity(0.14))
                        .frame(height: 5)
                }
            }

            VStack(alignment: .leading, spacing: 7) {
                Text(titles[step])
                    .font(.largeTitle.bold())

                Text(subtitles[step])
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.top, 8)
    }

    private var positionStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(PlayerPosition.allCases) { option in
                    SelectionButton(
                        title: option.rawValue,
                        icon: option.icon,
                        isSelected: position == option.rawValue
                    ) {
                        position = option.rawValue
                    }
                }
            }
            .padding(.vertical, 24)
        }
    }

    private var levelStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(PlayerLevel.allCases) { option in
                    SelectionButton(
                        title: option.rawValue,
                        icon: option.icon,
                        isSelected: level == option.rawValue
                    ) {
                        level = option.rawValue
                    }
                }
            }
            .padding(.vertical, 24)
        }
    }

    private var goalStep: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(ImprovementGoal.allCases) { option in
                    Button {
                        improvementGoal = option.rawValue
                    } label: {
                        VStack(alignment: .leading, spacing: 14) {
                            Image(systemName: option.icon)
                                .font(.title2)
                            Text(option.rawValue)
                                .font(.subheadline.weight(.semibold))
                            Image(systemName: improvementGoal == option.rawValue ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(improvementGoal == option.rawValue ? AppTheme.neon : .secondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 112, alignment: .leading)
                        .padding(15)
                        .foregroundStyle(improvementGoal == option.rawValue ? AppTheme.neon : Color.primary)
                        .background(improvementGoal == option.rawValue ? AppTheme.neon.opacity(0.11) : AppTheme.card)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(improvementGoal == option.rawValue ? AppTheme.neon.opacity(0.6) : Color.secondary.opacity(0.14))
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 24)
        }
    }

    private var frequencyStep: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                Circle()
                    .stroke(AppTheme.neon.opacity(0.16), lineWidth: 18)
                Circle()
                    .trim(from: 0, to: CGFloat(trainingsPerWeek) / 7)
                    .stroke(AppTheme.neon, style: StrokeStyle(lineWidth: 18, lineCap: .round))
                    .rotationEffect(.degrees(-90))

                VStack(spacing: 2) {
                    Text("\(trainingsPerWeek)")
                        .font(.system(size: 64, weight: .black, design: .rounded))
                    Text("por semana")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 220, height: 220)

            Stepper(value: $trainingsPerWeek, in: 1...7) {
                Text("Entrenamientos semanales")
                    .font(.headline)
            }
            .padding(18)
            .background(AppTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            Spacer()
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: 12) {
            if step > 0 {
                Button {
                    step -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .frame(width: 52, height: 52)
                        .background(Color.white.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .foregroundStyle(.primary)
            }

            Button {
                if step < 3 {
                    step += 1
                } else {
                    hasCompletedOnboarding = true
                }
            } label: {
                HStack {
                    Text(step == 3 ? "Entrar a Futsal IQ" : "Continuar")
                    Spacer()
                    Image(systemName: step == 3 ? "checkmark" : "chevron.right")
                }
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.horizontal, 18)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(AppTheme.neon)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
        .padding(.bottom, 4)
    }
}

#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}

