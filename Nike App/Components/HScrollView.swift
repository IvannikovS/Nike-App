import SwiftUI

struct HScrollView: View {
    let categories: [Scroll]
    let typeCard: String
    let typeAlignment: String
    var withNavigation: Bool = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                if typeCard == "bottom" {
                    if withNavigation {
                        ForEach(0..<categories.count, id: \.self) { index in
                            NavigationLink(destination: BestSellersView()) {
                                CardBottomLabelView(
                                    item: categories[index],
                                    type: typeAlignment
                                )
                            }
                        }
                    } else {
                        ForEach(0..<categories.count, id: \.self) { index in
                            CardBottomLabelView(
                                item: categories[index],
                                type: typeAlignment
                            )
                        }
                    }
                } else if typeCard == "onImage" {
                    ForEach(0..<categories.count, id: \.self) { index in
                        CardLabelOnImageView(
                            item: categories[index]
                        )
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, -20)
    }
}
