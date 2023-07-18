
import SwiftUI
import SDWebImageSwiftUI

struct ProductCellView: View {
    var product: Product
    
    var variantsText: String {
        if product.variantCount > 1 {
            return "\(product.variantCount) variants"
        } else {
            return "\(product.variantCount) variant"
        }
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                WebImage(url: product.imageURL)
                    .resizable()
                    .placeholder { Rectangle().foregroundColor(.gray) }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .scaledToFit()
                    .overlay(alignment: .bottomTrailing) {
                        Text(variantsText)
                            .foregroundColor(.black)
                            .font(.caption2).bold()
                            .italic()
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 6).fill(.mint.opacity(0.8)))
                            .offset(x: -5, y: -5)
                    }
                
                    Text(product.title)
                        .font(.body)
                        .foregroundColor(Color.primary)
                        .lineLimit(3, reservesSpace: true)
                        .multilineTextAlignment(.leading)
                        .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(.lightGray, lineWidth: 0.3))
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product.example)
            .frame(width: 150)
            
    }
}
