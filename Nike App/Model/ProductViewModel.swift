// ProductViewModel.swift
import Foundation
import Combine
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var selectedCategory: Category = .all
    @Published var availableCategories: [Category] = [.all]
    @Published var likedProductIDs: Set<String> = []
    
    let favoritesKey = "likedProducts"
    
    init() {
        loadProducts()
        loadLikedProducts()
        calculateAvailableCategories()
        filterProducts()
    }
    
    func loadProducts() {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            products = try decoder.decode([Product].self, from: data)
            updateProductsWithLikes()
            calculateAvailableCategories()
            filterProducts()
        } catch {
            print("Error loading products: \(error)")
        }
    }
    
    func toggleLike(for product: Product) {
        if likedProductIDs.contains(product.id.uuidString) {
            likedProductIDs.remove(product.id.uuidString)
        } else {
            likedProductIDs.insert(product.id.uuidString)
        }
        
        saveLikedProducts()
        updateProductsWithLikes()
        filterProducts()
        
        // Отправляем уведомление
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        objectWillChange.send()
    }
    
    func getLikedProducts() -> [Product] {
        return products.filter { likedProductIDs.contains($0.id.uuidString) }
    }
    
    func updateProductsWithLikes() {
        for i in 0..<products.count {
            products[i].isLiked = likedProductIDs.contains(products[i].id.uuidString)
        }
    }
    
    func saveLikedProducts() {
        let idsArray = Array(likedProductIDs)
        UserDefaults.standard.set(idsArray, forKey: favoritesKey)
    }
    
    func loadLikedProducts() {
        guard let savedIds = UserDefaults.standard.array(forKey: favoritesKey) as? [String] else {
            return
        }
        likedProductIDs = Set(savedIds)
    }
    
    func calculateAvailableCategories() {
        var categories: [Category] = [.all]
        
        for category in Category.allCases where category != .all {
            if hasProductsInCategory(category) {
                categories.append(category)
            }
        }
        
        availableCategories = categories
    }
    
    func hasProductsInCategory(_ category: Category) -> Bool {
        switch category {
        case .all:
            return !products.isEmpty
        case .tops:
            return products.contains { $0.productName.lowercased().contains("t-shirt") ||
                                       $0.productName.lowercased().contains("pullover") ||
                                       $0.productName.lowercased().contains("fleece") ||
                                       $0.productName.lowercased().contains("hoodie") }
        case .hoodies:
            return products.contains { $0.productName.lowercased().contains("hoodie") ||
                                       $0.productName.lowercased().contains("sweatshirt") ||
                                       $0.productName.lowercased().contains("crew") }
        case .shorts:
            return products.contains { $0.productName.lowercased().contains("shorts") }
        case .jackets:
            return products.contains { $0.productName.lowercased().contains("jacket") }
        case .pants:
            return products.contains { $0.productName.lowercased().contains("pants") ||
                                       $0.productName.lowercased().contains("tights") ||
                                       $0.productName.lowercased().contains("joggers") }
        case .equipment:
            return products.contains { $0.productName.lowercased().contains("backpack") ||
                                       $0.brand.contains("Elite") ||
                                       $0.brand.contains("Heritage") }
        }
    }
    
    func filterProducts() {
        switch selectedCategory {
        case .all:
            filteredProducts = products
        case .tops:
            filteredProducts = products.filter {
                $0.productName.lowercased().contains("t-shirt") ||
                $0.productName.lowercased().contains("pullover") ||
                $0.productName.lowercased().contains("fleece") ||
                $0.productName.lowercased().contains("hoodie")
            }
        case .hoodies:
            filteredProducts = products.filter {
                $0.productName.lowercased().contains("hoodie") ||
                $0.productName.lowercased().contains("sweatshirt") ||
                $0.productName.lowercased().contains("crew")
            }
        case .shorts:
            filteredProducts = products.filter { $0.productName.lowercased().contains("shorts") }
        case .jackets:
            filteredProducts = products.filter { $0.productName.lowercased().contains("jacket") }
        case .pants:
            filteredProducts = products.filter {
                $0.productName.lowercased().contains("pants") ||
                $0.productName.lowercased().contains("tights") ||
                $0.productName.lowercased().contains("joggers")
            }
        case .equipment:
            filteredProducts = products.filter {
                $0.productName.lowercased().contains("backpack") ||
                $0.brand.contains("Elite") ||
                $0.brand.contains("Heritage")
            }
        }
    }
}
