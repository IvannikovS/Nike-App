// ProductCardView.swift
import SwiftUI

struct ProductCardView: View {
    let product: Product
    let onLikeTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Изображение товара
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 150, height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 150, height: 150)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                // Кнопка лайка
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        onLikeTapped()
                    }
                }) {
                    Image(systemName: product.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(product.isLiked ? .red : .gray)
                        .padding(8)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                }
                .padding(8)
            }
            
            // Бренд
            if !product.brand.isEmpty {
                Text(product.brand)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            // Название товара
            Text(product.productName)
                .font(.system(size: 12))
                .fontWeight(.medium)
                .foregroundColor(.black)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            // Цена
            Text("$\(String(format: "%.2f", product.price))")
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            // Доступность
            if product.itemsLeft == 0 {
                Text("Sold Out")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 2)
            } else if product.itemsLeft < 10 {
                Text("Only \(product.itemsLeft) left")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.top, 2)
            }
            
            // Бестселлер
            if product.isBestseller {
                Text("Best Seller")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(4)
            }
        }
        .frame(width: 160)
        .padding(.vertical, 8)
    }
}
