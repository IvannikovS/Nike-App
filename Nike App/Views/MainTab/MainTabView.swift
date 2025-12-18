// MainTabView.swift
import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
                    .environmentObject(viewModel)
            }
            .tabItem { Label("Home", systemImage: "house") }

            NavigationStack {
                ShopView()
            }
            .tabItem { Label("Shop", systemImage: "magnifyingglass") }

            NavigationStack {
                FavoritesView()
                    .environmentObject(viewModel)
            }
            .tabItem { Label("Favorites", systemImage: "heart") }

            NavigationStack {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person") }
        }
        .tint(.black)
    }
}
