
import SwiftUI

struct ContentView: View {
    let networkManager = NetworkManager()
    
    @State private var isLoading = true
    @State private var categories: [Category] = Category.mocks
    
    var body: some View {
        NavigationView {
            CatalogGridView(categories: categories)
                .redacted(reason: isLoading ? .placeholder : [])
                .disabled(isLoading)
                .background {
                    if categories.isEmpty {
                        Text("Nothing to show here.")
                    }
                }
                .navigationTitle("Printful Catalog")
        }
        .task(loadCategories)
    }
    
    @Sendable func loadCategories() async {
        let urlString = "https://api.printful.com/categories"
        
        isLoading = true
        
        let results: GetCategoriesResults? = try? await networkManager.fetch(from: urlString)
        
        if let results = results {
            self.categories = results.result.categories
        } else {
            self.categories = []
        }
        
        isLoading = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
