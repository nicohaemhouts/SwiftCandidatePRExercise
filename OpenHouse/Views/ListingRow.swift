import SwiftUI

struct ListingRow: View {
    let listing: Listing

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ListingThumbnail(url: listing.imageURL)

            VStack(alignment: .leading, spacing: 4) {
                Text(listing.price, format: .currency(code: listing.currencyCode).precision(.fractionLength(0)))
                    .font(.headline)
                Text(listing.address)
                    .font(.body)
                Text(listing.suburb)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                ListingFeatures(
                    bedrooms: listing.bedrooms,
                    bathrooms: listing.bathrooms,
                    parking: listing.parking
                )
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}
