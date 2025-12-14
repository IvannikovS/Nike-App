import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            let tallH  = (h * 0.4) + 50
            let shortH = (h / 3.5) + 20

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    HStack(alignment: .top, spacing: 0) {
                        VStack(spacing: 0) {
                            Image("profile1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: w / 2, height: tallH)
                                .clipped()

                            Image("profile2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: w / 2, height: shortH)
                                .clipped()
                        }

                        VStack(spacing: 0) {
                            Image("profile3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: w / 2, height: shortH)
                                .clipped()

                            Image("profile4")
                                .resizable()
                                .scaledToFill()
                                .frame(width: w / 2, height: tallH)
                                .clipped()
                        }
                    }
                    // фиксируем высоту коллажа, чтобы он не “сжимался”
                    .frame(height: tallH + shortH)

                    Text("Welcome to the\nNike App")
                        .font(.custom("Inter", size: 24))
                        .fontWeight(.medium)
                        .padding(.top, 60)
                        .padding(.leading, 20)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
