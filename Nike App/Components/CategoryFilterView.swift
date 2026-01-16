import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategory: Category
    let availableCategories: [Category]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) { // Добавили отступ между категориями
                    ForEach(availableCategories, id: \.self) { category in
                        VStack(spacing: 8) {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selectedCategory = category
                                }
                            }) {
                                Text(category.rawValue)
                                    .font(.custom("Inter", size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(selectedCategory == category ? .black : .gray)
                            }
                            
                            Rectangle()
                                .fill(selectedCategory == category ? Color.black : Color.clear)
                                .frame(height: 3)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .background(Color.white)
            }
            
            Rectangle()
                .fill(Color.black.opacity(0.2))
                .frame(height: 1)
        }
    }
}
