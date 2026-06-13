import SwiftUI

struct RootView: View {
    @AppStorage(StorageKeys.hasCompletedOnboarding) private var hasCompletedOnboarding = false
    @AppStorage(StorageKeys.appearanceMode) private var appearanceMode = AppearanceMode.dark.rawValue

    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainTabView()
                    .transition(.opacity.combined(with: .scale(scale: 0.98)))
            } else {
                OnboardingView()
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(AppearanceMode(rawValue: appearanceMode)?.colorScheme)
        .tint(AppTheme.neon)
        .animation(.easeInOut(duration: 0.28), value: hasCompletedOnboarding)
    }
}

private struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Inicio", systemImage: "house.fill")
            }

            NavigationStack {
                BoardView()
            }
            .tabItem {
                Label("Tablero", systemImage: "sportscourt.fill")
            }

            NavigationStack {
                LearnView()
            }
            .tabItem {
                Label("Aprender", systemImage: "books.vertical.fill")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Perfil", systemImage: "person.crop.circle.fill")
            }
        }
        .toolbarBackground(.visible, for: .tabBar)
    }
}

#Preview {
    RootView()
}
