import SwiftUI

struct ContentView: View {
    @State private var currentScreen: AppScreen = .launch
    
    enum AppScreen {
        case launch, welcome, onboardingFirst, onboardingSecond, onboardingThirdView, shop
    }
    
    var body: some View {
        Group {
            switch currentScreen {
            case .launch:
                LaunchView {
                    withAnimation {
                        currentScreen = .welcome
                    }
                }
            case .welcome:
                WelcomeView {
                    withAnimation {
                        currentScreen = .onboardingFirst
                    }
                }
            case .onboardingFirst:
                OnboardingFirstView {
                    withAnimation {
                        currentScreen = .onboardingSecond
                    }
                }
                
            case .onboardingSecond:
                OnboardingSecondView {
                    withAnimation {
                        currentScreen = .onboardingThirdView
                    }
                }
            case .onboardingThirdView:
                OnboardingThirdView {
                    withAnimation {
                        currentScreen = .shop
                    }
                }
            case .shop:
                ShopView()
            }
        }
    }
}
