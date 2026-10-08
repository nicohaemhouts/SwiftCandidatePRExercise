import SwiftUI

struct ListingThumbnail: View {
    let url: URL?

    @ScaledMetric(relativeTo: .body) private var width: CGFloat = 96

    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(.quaternary)
            }
        }
        .frame(width: width, height: width * 0.75)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .accessibilityHidden(true)
    }
}
