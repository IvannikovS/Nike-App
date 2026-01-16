import SwiftUI

struct OnboardingThirdView: View {
    let onContinue: () -> Void
    @State private var selectedOptions: Set<String> = []
    
    private let categories = [
        ("Baseball", "Baseball"),
        ("Big & Tall", "Big & Tall"),
        ("Cross-Training", "Cross-Trainings"),
        ("Dance", "Dance"),
        ("Lacrosse", "Lacrosse"),
        ("Maternity", "Maternity"),
        ("N7", "N7"),
        ("Nike Sportswear", "Nike Sportwear")
    ]
    
    var body: some View {
        // 1. ОСНОВНОЙ ФОН
        let mainBackground = Color.black
            .ignoresSafeArea()
        
        // 2. ПРОГРЕСС БАР
        let progressBar = ProgressView(value: 1.0, total: 1.0)
            .progressViewStyle(.linear)
            .tint(.white)
            .scaleEffect(x: 1, y: 2)
            .frame(width: 200)
        
        // 3. ГРАДИЕНТ СВЕРХУ (5-10 пикселей)
        let topGradient = LinearGradient(
            gradient: Gradient(colors: [
                Color.black.opacity(1.0),
                Color.black.opacity(0.0)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 10)
        .frame(maxWidth: .infinity)
        
        // 4. ГРАДИЕНТ СНИЗУ (5-10 пикселей)
        let bottomGradient = LinearGradient(
            gradient: Gradient(colors: [
                Color.black.opacity(0.0),
                Color.black.opacity(1.0)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 10)
        .frame(maxWidth: .infinity)
        
        // 5. ЭЛЕМЕНТЫ СПИСКА
        let listItems = ForEach(Array(categories.enumerated()), id: \.offset) { index, category in
            let listItem = createListItem(title: category.0, imageName: category.1)
            
            VStack(spacing: 0) {
                listItem
                
                if index < categories.count - 1 {
                    createDivider()
                }
            }
        }
        
        // 6. СПИСОК КАТЕГОРИЙ С ГРАДИЕНТАМИ
        let categoriesList = ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Верхний градиент (над списком)
                    Color.clear.frame(height: 5)
                    
                    listItems
                    
                    // Нижний градиент (под списком)
                    Color.clear.frame(height: 5)
                }
                .padding(.vertical, 10)
            }
            .frame(maxHeight: .infinity)
            
            // Градиенты поверх списка
            VStack {
                topGradient
                    .frame(maxWidth: .infinity, alignment: .top)
                
                Spacer()
                
                bottomGradient
                    .frame(maxWidth: .infinity, alignment: .bottom)
            }
        }
        
        // 7. КНОПКА "NEXT"
        let nextButton = Button("Next") {
            onContinue()
        }
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(.black)
        .frame(width: 300, height: 50)
        .background(Color.white)
        .cornerRadius(25)
        .opacity(selectedOptions.isEmpty ? 0.5 : 1.0)
        .disabled(selectedOptions.isEmpty)
        
        // 8. ОСНОВНОЙ КОНТЕЙНЕР КОНТЕНТА
        let mainContentContainer = VStack(spacing: 0) {
            // Прогресс бар
            progressBar
                .padding(.top, 30)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // Список категорий с градиентами
            categoriesList
                .padding(.top, 10)
            
            // Кнопка Next
            nextButton
                .padding(.bottom, 40)
        }
        
        // 9. ФИНАЛЬНАЯ КОМПОЗИЦИЯ
        return ZStack {
            mainBackground
            
            mainContentContainer
        }
    }
    
    // MARK: - Вспомогательные компоненты
    
    // Создание разделителя
    private func createDivider() -> some View {
        Rectangle()
            .fill(Color.white.opacity(0.3))
            .frame(height: 1)
            .padding(.horizontal, 35)
    }
    
    // Создание элемента списка
    private func createListItem(title: String, imageName: String) -> some View {
        let isSelected = selectedOptions.contains(title)
        
        return HStack(spacing: 15) {
            // Изображение слева
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .clipShape(Circle())
            
            // Название категории
            Text(title)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            
            // Кружок-селектор справа
            ZStack {
                Circle()
                    .stroke(isSelected ? Color.white : Color.gray, lineWidth: 2)
                    .frame(width: 28, height: 28)
                
                if isSelected {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 16, height: 16)
                }
            }
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 18)
        .contentShape(Rectangle())
        .onTapGesture {
            toggleSelection(for: title)
        }
    }
    
    private func toggleSelection(for title: String) {
        if selectedOptions.contains(title) {
            selectedOptions.remove(title)
        } else {
            selectedOptions.insert(title)
        }
    }
}

#Preview {
    OnboardingThirdView(onContinue: {})
}
