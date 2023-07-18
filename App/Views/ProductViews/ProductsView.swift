
import SwiftUI

struct ProductsView: View {
    let networkManager = NetworkManager()
    
    var category: Category
    
    @State private var allowLoading = true
    @State private var isLoading = true
    @State private var products: [Product] = Product.mocks
    
    var body: some View {
        ProductsGridView(products: products)
            .redacted(reason: isLoading ? .placeholder : [])
            .disabled(isLoading)
            .background {
                if products.isEmpty {
                    Text("Nothing to show here.")
                }
            }
            .navigationTitle(category.title)
            .task(loadProducts)
    }
    
    @Sendable func loadProducts() async {
        if allowLoading {
            let urlString = "https://api.printful.com/products?category_id=\(category.id)"
            
            isLoading = true
            
            let results: Products? = try? await networkManager.fetch(from: urlString)
            
            if let results = results {
                self.products = results.result
                allowLoading = false
            } else {
                self.products = []
            }
            
            isLoading = false
        }
    }
}

struct ProductsForCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductsView(category: Category.example)
                .navigationTitle(Category.example.title)
        }
    }
}
