import Foundation
import Combine

class ProductDataService: ObservableObject {
    static let shared = ProductDataService()
    
    @Published var allProducts: [Product] = []
    @Published var likedProductIDs: Set<Int> = []
    
    private let favoritesKey = "likedProducts"
    
    private init() {
        loadProducts()
        loadLikedProducts()
    }
    
    func loadProducts() {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allProducts = try decoder.decode([Product].self, from: data)
            
            updateProductsWithLikes()
        } catch {
            print("Error loading products: \(error)")
        }
    }
    
    func toggleLike(for product: Product) {
        if likedProductIDs.contains(product.id) {
            likedProductIDs.remove(product.id)
        } else {
            likedProductIDs.insert(product.id)
        }
        
        saveLikedProducts()
        updateProductsWithLikes()
        
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        objectWillChange.send()
    }
    
    func getLikedProducts() -> [Product] {
        return allProducts.filter { likedProductIDs.contains($0.id) }
    }
    
    func isProductLiked(_ product: Product) -> Bool {
        return likedProductIDs.contains(product.id)
    }
    
    private func updateProductsWithLikes() {
        for i in 0..<allProducts.count {
            allProducts[i].isLiked = likedProductIDs.contains(allProducts[i].id)
        }
    }
    
    private func saveLikedProducts() {
        let idsArray = Array(likedProductIDs)
        UserDefaults.standard.set(idsArray, forKey: favoritesKey)
    }
    
    private func loadLikedProducts() {
        guard let savedIds = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] else {
            return
        }
        likedProductIDs = Set(savedIds)
    }
}

extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}
