
import SwiftUI

struct ProductsGridView: View {
    var products: [Product]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                Section {
                    ForEach(products) { product in
                        NavigationLink {
                            ProductDetailsView(product: product)    
                        } label: {
                            ProductCellView(product: product)
                        }
                    }
                }
            }
            .padding(.horizontal, 6)
        }
    }
}

struct ProductsGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsGridView(products: [Product.example])
    }
}
