import SwiftUI

struct BestSellersView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Best Sellers")
                .font(.title)
                .fontWeight(.semibold)

            Text("Заглушка экрана")
                .font(.body)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
        .navigationTitle("Best Sellers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        BestSellersView()
    }
}

