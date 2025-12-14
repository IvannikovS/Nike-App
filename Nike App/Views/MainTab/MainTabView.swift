import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ShopView().tabItem {
                Label("Shop", systemImage: "magnifyingglass")
            }
            ProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .tint(.black)
    }
}

