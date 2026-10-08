import SwiftUI

/// Pure rendering of loaded listings. Knows nothing about loading or errors.
struct ListingsContentView: View {
    let listings: [Listing]

    var body: some View {
        List(listings) { listing in
            NavigationLink(value: listing) {
                ListingRow(listing: listing)
            }
        }
        .listStyle(.plain)
    }
}
