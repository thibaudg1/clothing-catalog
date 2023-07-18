
import Foundation

struct GetCategoriesResults: Codable {
    let code: Int
    let result: Result
}

struct Result: Codable {
    let categories: [Category]
}

enum Size: String, Codable {
    case small = "small"
    case medium = "medium"
    case large = "large"
}

struct Category: Codable, Identifiable {
    let id: Int
    let parentID: Int
    let imageUrlString: String
    let catalogPosition: Int
    let size: Size
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case imageUrlString = "image_url"
        case catalogPosition = "catalog_position"
        case size
        case title
    }
    
    var imageURL: URL? {
        URL(string: imageUrlString)
    }
}

extension Category {
    static let example = Category(id: 22, parentID: 5, imageUrlString: "https://files.cdn.printful.com/o/upload/catalog_category/15/15b564814057a696d22fda3d4453fe8b_t?v=1666682055", catalogPosition: 14, size: .small, title: "Towels")
    
    static var mock: Category {
        Category(id: Int.random(in: 0...100000000000), parentID: 0, imageUrlString: "", catalogPosition: 0, size: .small, title: "Redacted Mock Category")
    }
    
    static var mocks: [Category] {
        var mocks = [Category]()
        for _ in 0...10 {
            mocks.append(Category.mock)
        }
        return mocks
    }
}
