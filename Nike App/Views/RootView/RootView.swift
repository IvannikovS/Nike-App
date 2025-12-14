import SwiftUI

struct RootView: View {
    @State private var isOnboardingDone = false

    var body: some View {
        if isOnboardingDone {
            MainTabView()
        } else {
            ContentView {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isOnboardingDone = true
                }
            }
        }
    }
}

#Preview {
    RootView()
}
