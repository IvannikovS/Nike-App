// Models.swift
import Foundation
import Combine

struct Product: Identifiable, Codable {
    let id = UUID()
    let brand: String
    let productName: String
    let price: Double
    let itemsLeft: Int
    let imageUrl: String
    var isLiked: Bool
    let isBestseller: Bool
    
    enum CodingKeys: String, CodingKey {
        case brand
        case productName = "product_name"
        case price
        case itemsLeft = "items_left"
        case imageUrl = "image_url"
        case isLiked = "is_liked"
        case isBestseller = "is_bestseller"
    }
}

enum Category: String, CaseIterable {
    case all = "All"
    case tops = "Tops & T-Shirts"
    case hoodies = "Hoodies & Pullover"
    case shorts = "Shorts"
    case jackets = "Jackets"
    case pants = "Pants & Tights"
    case equipment = "Accessories & Equipment"
    
    // Метод для фильтрации пустых категорий
    static func nonEmptyCategories(for products: [Product]) -> [Category] {
        return Category.allCases.filter { category in
            guard category != .all else { return true }
            
            let filteredCount = products.filter { product in
                switch category {
                case .all:
                    return true
                case .tops:
                    return product.productName.lowercased().contains("t-shirt") ||
                           product.productName.lowercased().contains("pullover") ||
                           product.productName.lowercased().contains("fleece") ||
                           product.productName.lowercased().contains("crew")
                case .hoodies:
                    return product.productName.lowercased().contains("hoodie") ||
                           product.productName.lowercased().contains("sweatshirt")
                case .shorts:
                    return product.productName.lowercased().contains("shorts")
                case .jackets:
                    return product.productName.lowercased().contains("jacket")
                case .pants:
                    return product.productName.lowercased().contains("pants") ||
                           product.productName.lowercased().contains("tights") ||
                           product.productName.lowercased().contains("joggers")
                case .equipment:
                    return product.productName.lowercased().contains("backpack") ||
                           product.brand.contains("Elite") ||
                           product.brand.contains("Heritage")
                }
            }.count
            
            return filteredCount > 0
        }
    }
}
