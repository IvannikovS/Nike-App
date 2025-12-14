import SwiftUI

struct TabView: View {
    @State private var selectedTab = 0
    let categoriesTabs: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                ForEach(0..<categoriesTabs.count, id: \.self) { index in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedTab = index
                        }
                    }) {
                        VStack(spacing: 8) {
                            Text(categoriesTabs[index])
                                .font(.custom("Inter", size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Rectangle()
                                .fill(selectedTab == index ? Color.black : Color.clear)
                                .frame(height: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 128)
            .background(Color.white)
            
            
            Rectangle()
                .fill(Color.black.opacity(0.2))
                .frame(height: 1)
        }
    }
}

