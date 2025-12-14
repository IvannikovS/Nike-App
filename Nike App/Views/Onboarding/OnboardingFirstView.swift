import SwiftUI

struct OnboardingFirstView: View {
    let onContinue: () -> Void
    
    // MARK: - Основные компоненты
    
    // 1. ФОН
    private var mainBackground: some View {
        Color.black
            .ignoresSafeArea()
    }
    
    // 2. КОЛЛАЖ ИЗОБРАЖЕНИЙ
    private var imageCollage: some View {
        HStack(spacing: 15) {
            leftColumn
            rightColumn
        }
        .padding(.horizontal, -20)
    }
    
    // 3. ЛЕВАЯ КОЛОНКА ИЗОБРАЖЕНИЙ
    private var leftColumn: some View {
        VStack(spacing: 15) {
            createImage("Screen5_1", width: 100, height: 125)
            createImage("Screen5_3", width: 130, height: 155)
            createImage("Screen5_6", width: 130, height: 250)
            createImage("Screen5_7", width: 130, height: 130)
        }
    }
    
    // 4. ПРАВАЯ КОЛОНКА ИЗОБРАЖЕНИЙ
    private var rightColumn: some View {
        VStack(spacing: 15) {
            createImage("Screen5_2", width: 200, height: 145)
            createImage("Screen5_4", width: 200, height: 250)
            twoImagesRow
            createImage("Screen5_5", width: 200, height: 165)
        }
    }
    
    // 5. ДВА ИЗОБРАЖЕНИЯ РЯДОМ
    private var twoImagesRow: some View {
        HStack(spacing: 10) {
            createImage("Screen5_8", width: 95, height: 150)
            createImage("Screen5_9", width: 95, height: 150)
        }
    }
    
    // 6. ГРАДИЕНТ ПОВЕРХ ИЗОБРАЖЕНИЙ
    private var gradientOverlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .black.opacity(0.85),
                .black.opacity(0.4),
                .black.opacity(0.1),
                .clear
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    // 7. ПРОГРЕСС БАР
    private var progressBar: some View {
        ProgressView(value: 0.5, total: 1.0)
            .progressViewStyle(.linear)
            .tint(.white)
            .scaleEffect(x: 1, y: 2)
            .frame(width: 200)
    }
    
    
    // 8. ТЕКСТ
    private var descriptionText: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("To personalize your")
            Text("experience and")
            Text("connect you to sport,")
            Text("we've got a few...")
        }
        .font(.system(size: 36, weight: .semibold))
        .foregroundColor(.white)
    }
    
    // 9. КНОПКА
    private var getStartedButton: some View {
        Button("Get Started") {
            onContinue()
        }
        .font(.system(size: 22, weight: .medium))
        .foregroundColor(.black)
        .frame(width: 320, height: 65)
        .background(Color.white)
        .cornerRadius(35)
    }
    
    // 10. ВЕРХНИЙ БЛОК КОНТЕНТА
    private var topContentBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            progressBar
                .padding(.top, 60)
                .frame(maxWidth: .infinity, alignment: .center)
            
            descriptionText
                .padding(.top, 40)
                .padding(.leading, 25)
        }
    }
    
    // 11. ОСНОВНОЙ КОНТЕЙНЕР КОНТЕНТА
    private var mainContentContainer: some View {
        VStack(alignment: .leading, spacing: 0) {
            topContentBlock
            
            Spacer()
            
            getStartedButton
                .padding(.bottom, 60)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // СЛОЙ 1: Основной фон
                mainBackground
                
                // СЛОЙ 2: Коллаж изображений
                imageCollage
                    .frame(width: geometry.size.width + 40)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                // СЛОЙ 3: Градиент
                gradientOverlay
                
                // СЛОЙ 4: Контент
                mainContentContainer
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    // MARK: - Вспомогательная функция
    private func createImage(_ name: String, width: CGFloat, height: CGFloat) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .cornerRadius(10)
            .clipped()
    }
}

#Preview {
    OnboardingFirstView(onContinue: {})
}
