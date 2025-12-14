import SwiftUI

struct SectionList: View {
    
    let sections: [Scroll]
        
    var body: some View {
        VStack() {
            ForEach(0..<sections.count, id: \.self) { index in
                SectionView(item: sections[index])
            }
        }
        .padding(.horizontal, -20)
    }
}

struct SectionView: View {
    let item: Scroll
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(item.imageLabel)
                .resizable()
                .scaledToFill()
                .frame(height: 111, alignment: .topLeading)
                .clipped()
                .overlay(
                    Rectangle().foregroundColor(.black.opacity(0.25))
                )
            Text(item.label)
                .font(.custom("Inter", size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.leading, 20)
        }
        .frame(height: 111)
    }
}
