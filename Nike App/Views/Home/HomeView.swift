import SwiftUI

struct HomeView: View {

    // Заглушки — замени на свои модели/данные
    private let interests: [InterestItem] = [
        .init(title: "Running", imageName: "N7"),
        .init(title: "Football", imageName: "interest_football")
    ]

    private let products: [ProductItem] = [
        .init(title: "Nike Force 1’07 White", imageName: "shoe_white"),
        .init(title: "New Balance 2002R", imageName: "shoe_blue")
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {

                // MARK: Header
                HStack(alignment: .firstTextBaseline) {
                    Text("Shop My Interests")
                        .font(.system(size: 18, weight: .semibold))

                    Spacer()

                    Button {
                        // TODO: Add Interest action
                    } label: {
                        Text("Add Interest")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)

                // MARK: Interests 2 columns
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 10),
                        GridItem(.flexible(), spacing: 10)
                    ],
                    spacing: 10
                ) {
                    ForEach(interests) { item in
                        InterestGridTile(item: item)
                    }
                }
                .padding(.horizontal, 16)

                // MARK: Recommended
                Text("Recommended for You")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.horizontal, 16)
                    .padding(.top, 10)

                // MARK: Products 2 columns
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 18),
                        GridItem(.flexible(), spacing: 18)
                    ],
                    spacing: 18
                ) {
                    ForEach(products) { p in
                        ProductGridTile(item: p)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .background(Color.white)
        // если экран внутри NavigationStack — гарантируем отсутствие back-кнопки
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Tiles

struct InterestGridTile: View {
    let item: InterestItem

    var body: some View {
        ZStack(alignment: .center) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipped()

            // легкое затемнение
            Rectangle()
                .fill(Color.black.opacity(0.18))

            Text(item.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
}

struct ProductGridTile: View {
    let item: ProductItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray6))
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))

                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 90)
                    .padding(.top, 6)
            }

            Text(item.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.black)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Models (заглушки)
struct InterestItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct ProductItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

// MARK: - Preview
#Preview {
    HomeView()
}
