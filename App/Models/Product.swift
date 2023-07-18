
import Foundation

struct Products: Codable {
    let code: Int
    let result: [Product]
}

struct Product: Codable, Identifiable {
    let id: Int
    let mainCategoryID: Int
    let type: String
    let typeName: String
    let title: String
    let brand: String?
    let model: String
    let image: String
    let variantCount: Int
    let currency: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id
        case mainCategoryID = "main_category_id"
        case type
        case typeName = "type_name"
        case title
        case brand
        case model
        case image
        case variantCount = "variant_count"
        case currency
        case description
    }
    
    var imageURL: URL? {
        URL(string: image)
    }
}

extension Product {
    static let example = Product(id: 441, mainCategoryID: 22, type: "EMBROIDERY", typeName: "ARTG Big towel", title: "Turkish Cotton Towel | ARTG AR038", brand: "ARTG", model: "AR038", image: "https://files.cdn.printful.com/o/products/441/product_1606198428.jpg", variantCount: 8, currency: "USD", description: "This premium towel is made from a high-quality absorbent fabric and will last a long time, whether you use it at home, or by the beach. It's made from 100% combed Turkish cotton that's extra soft and fluffy.\r\n\r\n• 100% combed Turkish cotton\r\n• Fabric weight: oversized weighs 13.3 oz/yd² (450 g/m²), bath and hand towels weigh 14.7 oz/yd² (500 g/m²)\r\n• Absorbent fabric\r\n• Made extra soft with the new AirJet Technology\r\n• Pre-shrunk for additional durability\r\n• Decorative shiny woven motif on both ends\r\n• Sizes: oversized is 39.4″ × 82.7″ (100 × 210 cm), bath is 27.6″ × 55.1″ (70 × 140 cm), and hand towel is 19.7″ × 39.4″ (50 × 100 cm)\r\n• Suitable for indoor and outdoor use\r\n• Blank product sourced from Turkey")
    
    static var mock: Product {
        Product(id: Int.random(in: 0...1000000000), mainCategoryID: 0, type: "Mock", typeName: "MOCK", title: "A mock product", brand: "Noname Brand", model: "OneSize", image: "", variantCount: 8, currency: "USD", description: "The best mock product ever")
    }
    
    static var mocks: [Product] {
        var mocks = [Product]()
        for _ in  0...10 {
            mocks.append(Product.mock)
        }
        return mocks
    }
}
