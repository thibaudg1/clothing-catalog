
import SwiftUI

struct CatalogGridView: View {
    var categories: [Category]
    
    var rootCat: [Category] {
        categories.filter { $0.parentID == 0 }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(rootCat) { cat in
                    VStack(alignment: .leading) {
                        Divider()
                            .padding([.horizontal])
                        
                        HStack {
                            Text(cat.title)
                                .font(.title3)
                                .bold()
                            Spacer()
                            NavigationLink {
                                ProductsView(category: cat)
                            } label: {
                                Text("See all")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                    .padding(.horizontal)
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(Color.primary, lineWidth: 1)
                                    )
                            }
                        }
                        .padding([.horizontal])
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 0) {
                                ForEach(categories(for: cat.id)) { cat in
                                    NavigationLink {
                                        ProductsView(category: cat)
                                    } label: {
                                        CategoryCellView(category: cat)
                                            .frame(width: 150)
                                            .padding(.horizontal, 5)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 25)
                }
            }
            
            HStack {
                Text("Discover more")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Spacer()
            }
            .padding(.top)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                Section {
                    ForEach(discoverCategories()) { category in
                        NavigationLink {
                            ProductsView(category: category)
                        } label: {
                            CategoryCellView(category: category)
                        }
                    }
                }
            }
            .padding(.horizontal, 6)
        }
    }
    
    func categories(for parentId: Int) -> [Category] {
        categories.filter { $0.parentID == parentId }
    }
    
    func discoverCategories() -> [Category] {
        var doNotShowCategoryIDs = [Int]()
        doNotShowCategoryIDs.append(contentsOf: rootCat.map(\.id))
        rootCat.forEach { doNotShowCategoryIDs.append(contentsOf: categories(for: $0.id).map(\.id))}
        
        return categories.filter { !doNotShowCategoryIDs.contains($0.id) }
    }
}

struct CatalogGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CatalogGridView(categories: [Category.example])
                .navigationTitle("Printful Explorer")
        }
    }
}
