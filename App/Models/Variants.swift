
import Foundation

struct GetVariantsResponse: Codable {
    let code: Int
    let result: GetVariantsResult
}

struct GetVariantsResult: Codable {
    let product: Product
    let variants: [Variant]
}

struct Variant: Codable, Identifiable {
    let id, productID: Int
    let name: String
    let size: String?
    let color, colorCode: String?
    let image: String
    let price: String
    let inStock: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, size, color
        case colorCode = "color_code"
        case image, price
        case inStock = "in_stock"
    }
    
    var imageURL: URL? {
        URL(string: image)
    }
}
