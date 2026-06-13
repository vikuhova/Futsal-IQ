import SwiftUI

struct LearnView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 24) {
                ScreenHeader(
                    eyebrow: "Biblioteca",
                    title: "Aprender",
                    subtitle: "Ideas cortas para usar en el próximo entrenamiento.",
                    icon: "books.vertical.fill"
                )

                ForEach(LearningCategory.allCases) { category in
                    learningSection(category)
                }
            }
            .padding(20)
            .padding(.bottom, 16)
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
    }

    private func learningSection(_ category: LearningCategory) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(title: category.rawValue, icon: category.icon, color: category.color)

            ForEach(AppContent.learningItems.filter { $0.category == category }) { item in
                SportCard(accent: category.color) {
                    VStack(alignment: .leading, spacing: 10) {
                        CapsuleTag(text: category.rawValue, icon: category.icon, color: category.color)
                        Text(item.title)
                            .font(.headline)
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LearnView()
    }
    .preferredColorScheme(.dark)
}
