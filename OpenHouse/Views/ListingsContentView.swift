import SwiftUI

/// Pure rendering of loaded listings. Knows nothing about loading or errors.
struct ListingsContentView: View {
    let listings: [Listing]

    var body: some View {
        List {
            ForEach(listings.indices, id: \.self) { index in
                NavigationLink(value: listings[index]) {
                    ListingRow(listing: listings[index])
                }
                .listRowBackground(index.isMultiple(of: 2) ? Color.clear : Color(.secondarySystemBackground))
            }
        }
        .listStyle(.plain)
    }
}
