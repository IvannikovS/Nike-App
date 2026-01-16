import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var refreshID = UUID()
    
    var body: some View {
            NavigationStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Favorites")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)

                    if viewModel.getLikedProducts().isEmpty {
                        emptyStateView
                    } else {
                        productsGridView
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
                .id(refreshID)
                .onAppear {
                    viewModel.loadLikedProducts()
                    viewModel.updateProductsWithLikes()
                }
                .onReceive(NotificationCenter.default.publisher(for: .favoritesUpdated)) { _ in
                    viewModel.loadLikedProducts()
                    viewModel.updateProductsWithLikes()
                    refreshID = UUID()
                }
            }
        }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No favorites yet")
                .font(.title3)
                .foregroundColor(.gray)
            
            Text("Tap the heart icon to add products to favorites")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var productsGridView: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {
                ForEach(viewModel.getLikedProducts()) { product in
                    ProductCardView(product: product) {
                        viewModel.toggleLike(for: product)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
}

#Preview {
    FavoritesView()
}
