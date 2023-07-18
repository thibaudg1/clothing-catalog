
import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailsView: View {
    let networkManager = NetworkManager()
    
    var product: Product
    
    @State private var readMore = false
    @State private var favorite = false
    
    @State private var mainImageUrl: URL?
    
    @State private var variants = [Variant]()
    var colorVariants: [Variant] {
        var variants = [Variant]()
        self.variants.forEach { vari1 in
            if !variants.contains(where: { vari2 in
                vari1.colorCode == vari2.colorCode
            }) {
                variants.append(vari1)
            }
        }
        
        return variants
    }
    
    @State private var quantity = 1
    var total: Double {
        guard let variant = (variants.first { $0.price != "" }) else { return 0 }
        let unitPrice = Double(variant.price) ?? 0.0
        
        return (Double(quantity) * unitPrice)
    }
    var totalText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let totalString = formatter.string(for: total) ?? ""
        return "\(product.currency) \(totalString)"
    }
    
    var sizes: [String] {
        variants.compactMap(\.size).unique().sorted()
    }
    
    var body: some View {
        ScrollView {
            Group {
                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Text(product.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(product.model)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("Description")
                            .bold()
                        
                        Text(product.description)
                            .font(.caption)
                            .lineLimit(readMore ? nil : 5)
                            .overlay(alignment: .bottomTrailing) {
                                Text(readMore ? "Read less" : "Read more")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                                    .bold()
                                    .onTapGesture {
                                        readMore.toggle()
                                    }
                                    .offset(x: 0, y: 18)
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 20)

                VStack {
                    WebImage(url: mainImageUrl)
                    .resizable()
                    .placeholder { Rectangle().foregroundColor(.gray) }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .overlay(alignment: .bottomTrailing) {
                        Text(product.brand ?? "")
                            .font(.caption2)
                            .italic()
                            .offset(x: -10, y: -10)
                            
                    }
                    .frame(height: 500)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(.lightGray, lineWidth: 0.3)
                        .shadow(radius: 4)
                    )
                    
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            WebImage(url: product.imageURL)
                                .resizable()
                                .placeholder { Rectangle().foregroundColor(.gray) }
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFit()
                                .onTapGesture {
                                    mainImageUrl = product.imageURL
                                }
                            
                            ForEach(colorVariants) { variant in
                                WebImage(url: variant.imageURL)
                                    .resizable()
                                    .placeholder { Rectangle().foregroundColor(.gray) }
                                    .indicator(.activity)
                                    .transition(.fade(duration: 0.5))
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .overlay(RoundedRectangle(cornerRadius: 6)
                                        .stroke(.lightGray, lineWidth: 0.3)
                                        .shadow(radius: 4)
                                    )
                                    .onTapGesture {
                                        mainImageUrl = variant.imageURL
                                    }
                            }
                        }
                        .frame(height: 40)
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(sizes, id: \.self) { size in
                            Text(size)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .padding(6)
                                .overlay(RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.3)
                                )
                        }
                    }
                }
                .padding(.vertical, 12)
                
                HStack {
                    HStack {
                        Image(systemName: "minus.circle.fill").onTapGesture {
                            if quantity > 1 { quantity -= 1 }
                        }
                        Text("\(quantity)")
                            .foregroundColor(.primary)
                            .font(.title3)
                        Image(systemName: "plus.circle.fill").onTapGesture {
                            quantity += 1
                        }
                    }
                    .foregroundColor(.gray)
                    .font(.title3)
                    
                    Spacer()
                    Text("Total:")
                    Text(totalText)
                        .font(.title2)
                        .bold()
                }
                
                Button { } label: {
                    Rectangle()
                        .foregroundColor(.pink)
                        .cornerRadius(15)
                        .frame(height: 44)
                        .overlay {
                            Label("Add to cart", systemImage: "cart.circle.fill")
                                .foregroundColor(.white)
                                .font(Font.title3)
                        }
                    
                }
            }
            .padding()
        }
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    favorite.toggle()
                } label: {
                    Image(systemName: favorite ? "heart.fill" : "heart")
                }
            }
        }
        .onAppear {
            mainImageUrl = product.imageURL
        }
        .task(loadVariants)
        
    }
    
    @Sendable func loadVariants() async {
        let urlString = "https://api.printful.com/products/\(product.id)"
        
        let results: GetVariantsResponse? = try? await networkManager.fetch(from: urlString)
        
        if let results = results {
            self.variants = results.result.variants
        } else {
            self.variants = []
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailsView(product: Product.example)
        }
    }
}
