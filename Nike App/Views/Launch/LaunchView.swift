import SwiftUI

struct LaunchView: View {
    let onComplete: () -> Void
    
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                Image("NikeLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                onComplete()
            }
        }
    }
}


#Preview {
    LaunchView(onComplete: {})
}
