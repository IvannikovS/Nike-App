import SwiftUI

struct BestSellersView: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var refreshID = UUID()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Text("Best Sellers")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 8)
                
                // Фильтр категорий
                CategoryFilterView(
                    selectedCategory: $viewModel.selectedCategory,
                    availableCategories: viewModel.availableCategories
                )
                .onChange(of: viewModel.selectedCategory) {
                    viewModel.filterProducts()
                }
                
                // Сетка товаров
                if viewModel.filteredProducts.isEmpty {
                    emptyProductsView
                } else {
                    productsGridView
                }
            }
            .navigationBarHidden(true)
            .id(refreshID)
            .onAppear {
                viewModel.filterProducts()
            }
            .onReceive(NotificationCenter.default.publisher(for: .favoritesUpdated)) { _ in
                refreshID = UUID()
            }
        }
    }
    
    private var emptyProductsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cube.box")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No products in this category")
                .font(.title3)
                .foregroundColor(.gray)
            
            Text("Try selecting a different category")
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
                ForEach(viewModel.filteredProducts) { product in
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
    NavigationStack {
        BestSellersView()
    }
}

