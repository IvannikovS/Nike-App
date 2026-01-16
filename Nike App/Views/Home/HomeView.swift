import SwiftUI

struct HomeView: View {
    let categories: [Scroll] = [
        Scroll(label: "Running", imageLabel: "running"),
        Scroll(label: "Swimming", imageLabel: "swimming"),
        Scroll(label: "Basketball", imageLabel: "basketball"),
    ]
    
    let snickers: [Scroll] = [
        Scroll(label: "Nike Force 1", imageLabel: "nikeforce1"),
        Scroll(label: "Nike Jordan", imageLabel: "nikeJordan"),
        Scroll(label: "Nike SB", imageLabel: "nikeSBDunk"),
    ]
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text("Shop My Interests")
                    .font(.custom("Inter", size: 20))
                    .fontWeight(.semibold)
                Spacer()
                Text("Add Interest")
                    .font(.custom("Inter", size: 17))
                    .fontWeight(.regular)
            }
            .padding(.horizontal, 20)
            ScrollView {
                VStack {
                    HStack {
                        HScrollView(
                            categories: categories,
                            typeCard: "onImage",
                            typeAlignment: "categories"
                        )
                    }
                    .padding(.top, 25)
                    
                    HStack {
                        Text("Recommended for You")
                            .font(.custom("Inter", size: 21))
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding(.top, 77)
                    
                    HStack {
                        HScrollView(categories: snickers, typeCard: "bottom", typeAlignment: "snickers")
                    }
                    .padding(.top, 15)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            
        }
        .padding(.top, 20)
    }
}

#Preview {
    HomeView()
}
