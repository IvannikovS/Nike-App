import SwiftUI

struct OnboardingSecondView: View {
    let onContinue: () -> Void
    @State private var selectedOptions: Set<String> = []
    
    var body: some View {
        // 1. ОСНОВНОЙ ФОН
        let mainBackground = Color.black
            .ignoresSafeArea()
        
        // 2. ПРОГРЕСС БАР
        let progressBar = ProgressView(value: 0.75, total: 1.0)
            .progressViewStyle(.linear)
            .tint(.white)
            .scaleEffect(x: 1, y: 2)
            .frame(width: 200)
        
        // 3. ЗАГОЛОВОК (УМЕНЬШИМ И СДЕЛАЕМ В ДВЕ СТРОКИ)
        let titleText = VStack(spacing: 4) {
            Text("First up, which products do you use the most?")
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(.white)
        }
        .multilineTextAlignment(.center)
        .lineSpacing(4)
        
        // 4. СПИСОК ОПЦИЙ С РАЗДЕЛИТЕЛЯМИ
        let optionsList = VStack(spacing: 0) {
            // Mens
            createListItem(title: "Mens", imageName: "mans")
            
            // Белая линия разделитель
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal, 35)
            
            // Womens
            createListItem(title: "Womens", imageName: "womans")
            
            // Разделитель с текстом
            Text("Any others?")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.gray)
                .padding(.vertical, 20)
            
            // Boys
            createListItem(title: "Boys", imageName: "boys")
            
            // Белая линия разделитель
            Rectangle()
                .fill(Color.white.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal, 35)
            
            // Girls
            createListItem(title: "Girls", imageName: "girls")
        }
        
        // 5. КНОПКА "GET STARTED"
        let getStartedButton = Button("Get Started") {
            onContinue()
        }
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(.black)
        .frame(width: 300, height: 50)
        .background(Color.white)
        .cornerRadius(25)
        .opacity(selectedOptions.isEmpty ? 0.5 : 1.0)
        .disabled(selectedOptions.isEmpty)
        
        // 6. ОСНОВНОЙ КОНТЕЙНЕР
        let mainContentContainer = VStack(spacing: 20) {
            // Прогресс бар
            progressBar
                .padding(.top, 40)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // Заголовок
            titleText
                .padding(.horizontal, 30)
                .padding(.top, 20)
            
            Spacer()
            
            // Список опций
            optionsList
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            // Кнопка продолжения
            getStartedButton
                .padding(.bottom, 30)
        }
        
        // 7. ФИНАЛЬНАЯ КОМПОЗИЦИЯ
        return ZStack {
            mainBackground
            
            mainContentContainer
        }
    }
    
    // Функция для создания элемента списка
    private func createListItem(title: String, imageName: String) -> some View {
        let isSelected = selectedOptions.contains(title)
        
        return HStack(spacing: 15) {
            // Изображение слева
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
            // Название
            Text(title)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            
            // Кружок-селектор справа
            ZStack {
                Circle()
                    .stroke(isSelected ? Color.white : Color.gray, lineWidth: 2)
                    .frame(width: 24, height: 24)
                
                if isSelected {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 14, height: 14)
                }
            }
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 16)
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
    OnboardingSecondView(onContinue: {})
}
