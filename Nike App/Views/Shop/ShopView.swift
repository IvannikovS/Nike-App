import SwiftUI

struct ShopView: View {
    let categoriesTabs = ["Men", "Women", "Kids"]
    
    let categories: [Scroll] = [
        Scroll(label: "Best Sellers", imageLabel: "bestSellers"),
        Scroll(label: "Featured In Nike Air", imageLabel: "featuredInNikeAir"),
        Scroll(label: "Just Do It", imageLabel: "justDoIt"),
    ]
    
    let sections: [Scroll] = [
        Scroll(label: "New&Featured", imageLabel: "newFeatured"),
        Scroll(label: "Shooes", imageLabel: "sectionShooes"),
        Scroll(label: "Sales", imageLabel: "sales"),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("searchIcon")
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            HStack {
                Text("Shop")
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal, 20)

            HStack {
                TabView(categoriesTabs: categoriesTabs)
            }
            .padding(.top, 32)
            
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Must-Haves, Best Sellers & More ")
                            .font(.body)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack {
                        HScrollView(categories: categories, typeCard: "bottom", typeAlignment: "categories")
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 5) {
                        SectionList(sections: sections)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            Spacer()
            
        }
       // .navigationBarBackButtonHidden(false)
        
    }
}


#Preview {
    ShopView()
}

#Preview("Dark Mode") {
    ShopView()
        .preferredColorScheme(.dark)
}
