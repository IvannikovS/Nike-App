import SwiftUI

struct ProductCardView: View {
    let product: Product
    let onLikeTapped: () -> Void

    private let imageSize: CGFloat = 150

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // MARK: - Image
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()

                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding(24)
                            .foregroundColor(.gray)

                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: imageSize, height: imageSize)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        onLikeTapped()
                    }
                } label: {
                    Image(systemName: product.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(product.isLiked ? .red : .gray)
                        .padding(8)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                }
                .padding(8)
            }

            // MARK: - Brand (резервируем строку)
            Text(product.brand.isEmpty ? " " : product.brand)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                .frame(height: 14)

            // MARK: - Product name (всегда 2 строки)
            Text(product.productName)
                .font(.system(size: 12))
                .fontWeight(.medium)
                .foregroundColor(.black)
                .lineLimit(2)
                .frame(height: 32, alignment: .top)

            // MARK: - Price
            Text("$\(String(format: "%.2f", product.price))")
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(height: 18)

            // MARK: - Availability (всегда резервируем место)
            Group {
                if product.itemsLeft == 0 {
                    Text("Sold Out")
                        .foregroundColor(.red)
                } else if product.itemsLeft < 10 {
                    Text("Only \(product.itemsLeft) left")
                        .foregroundColor(.orange)
                } else {
                    Text(" ")
                }
            }
            .font(.caption)
            .frame(height: 16)

            // MARK: - Bestseller badge (резервируем)
            Group {
                if product.isBestseller {
                    Text("Best Seller")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(4)
                } else {
                    Color.clear
                        .frame(height: 16)
                }
            }
        }
        .frame(width: 160, alignment: .topLeading)
        .padding(.vertical, 8)
    }
}
