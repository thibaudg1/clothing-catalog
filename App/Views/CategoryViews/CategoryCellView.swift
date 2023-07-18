
import SwiftUI
import SDWebImageSwiftUI

struct CategoryCellView: View {
    var category: Category
    
    var body: some View {
        VStack {
            WebImage(url: category.imageURL)
                .resizable()
                .placeholder { Rectangle().foregroundColor(.gray) }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
            
            Text(category.title)
                .foregroundColor(.gray)
                .bold()
                .lineLimit(1)
                .padding(.vertical)
        } 
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(.lightGray, lineWidth: 0.3)
            .shadow(radius: 4)
        )
    }
}

struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCellView(category: Category.example)
    }
}
