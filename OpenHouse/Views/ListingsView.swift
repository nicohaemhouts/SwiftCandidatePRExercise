import SwiftUI

/// Loading view: owns the store, switches over its state, and triggers fetches.
struct ListingsView: View {
    @State private var store: ListingsStore

    init(service: any ListingProviding) {
        _store = State(wrappedValue: ListingsStore(service: service))
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Listings")
                .navigationDestination(for: Listing.self) { listing in
                    ListingDetailView(listing: listing)
                }
        }
        .task {
            await store.fetchListings()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch store.listingsState {
        case .success(let listings):
            ListingsContentView(listings: listings)
                .refreshable {
                    await store.fetchListings()
                }

        case .loading, .none:
            ListingsContentView(listings: Listing.loadingMocks)
                .redacted(reason: .placeholder)
                .allowsHitTesting(false)

        case .failure:
            ListingsErrorView {
                await store.fetchListings()
            }
        }
    }
}

#Preview {
    ListingsView(service: FixtureListingService(delay: .zero))
}
