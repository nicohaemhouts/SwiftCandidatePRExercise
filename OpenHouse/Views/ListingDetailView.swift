import SwiftUI

struct ListingDetailView: View {
    let listing: Listing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ListingHeroImage(url: listing.imageURL)
                ListingSummary(
                    price: listing.price,
                    currencyCode: listing.currencyCode,
                    address: listing.address,
                    suburb: listing.suburb,
                    listedAt: listing.listedAt
                )
                ListingFeatures(
                    bedrooms: listing.bedrooms,
                    bathrooms: listing.bathrooms,
                    parking: listing.parking
                )
            }
            .padding()
        }
        .navigationTitle(listing.suburb)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ListingDetailView(listing: Listing.loadingMocks[0])
    }
}
