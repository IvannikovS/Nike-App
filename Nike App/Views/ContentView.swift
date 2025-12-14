//import SwiftUI
//
//enum OnRoute: Hashable {
//    case welcome
//    case onboarding1
//    case onboarding2
//    case onboarding3
//    case shop
//}
//
//struct ContentView: View {
//    @State private var path = NavigationPath()
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            LaunchView {
//                path.append(OnRoute.welcome)
//            }
//            .navigationDestination(for: OnRoute.self) { route in
//                switch route {
//                case .welcome:
//                    WelcomeView { path.append(OnRoute.onboarding1) }
//                        .navigationBarBackButtonHidden(true)
//                case .onboarding1:
//                    OnboardingFirstView { path.append(OnRoute.onboarding2) }
//                        .navigationBarBackButtonHidden(true)
//                case .onboarding2:
//                    OnboardingSecondView { path.append(OnRoute.onboarding3) }
//                        .navigationBarBackButtonHidden(true)
//                case .onboarding3:
//                    OnboardingThirdView {
//                        // заменяем стек на shop (чтобы назад уже не было)
//                        path = NavigationPath()
//                        path.append(OnRoute.shop)
//                    }
//                    .navigationBarBackButtonHidden(true)
//                case .shop:
//                    ShopView()
//                        .navigationBarBackButtonHidden(true) // если надо убрать back
//                }
//            }
//        }
//    }
//}


import SwiftUI

enum OnRoute: Hashable {
    case welcome
    case onboarding1
    case onboarding2
    case onboarding3
}

struct ContentView: View {
    let onFinish: () -> Void
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            LaunchView {
                path.append(OnRoute.welcome)
            }
            .navigationDestination(for: OnRoute.self) { route in
                switch route {
                case .welcome:
                    WelcomeView { path.append(OnRoute.onboarding1) }
                        .navigationBarBackButtonHidden(true)

                case .onboarding1:
                    OnboardingFirstView { path.append(OnRoute.onboarding2) }
                        .navigationBarBackButtonHidden(true)

                case .onboarding2:
                    OnboardingSecondView { path.append(OnRoute.onboarding3) }
                        .navigationBarBackButtonHidden(true)

                case .onboarding3:
                    OnboardingThirdView {
                        onFinish() // <- вот тут включаем табы
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

