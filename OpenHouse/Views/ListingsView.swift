import SwiftUI

/// Loading view: switches over the store's state and triggers fetches.
struct ListingsView: View {
    @Environment(ListingsStore.self) private var store

    @State var query = ""
    @State private var isShowingFilters = false

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Listings")
                .navigationDestination(for: Listing.self) { listing in
                    ListingDetailView(listing: listing)
                }
                .searchable(text: $query, prompt: "Search suburb or street")
                .onChange(of: query) { newValue in
                    store.filter.query = newValue
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Sort", selection: Binding(
                                get: { store.filter.sort },
                                set: { store.filter.sort = $0 }
                            )) {
                                ForEach(ListingFilter.Sort.allCases, id: \.self) { sort in
                                    Text(sort.title).tag(sort)
                                }
                            }
                            Picker("Property type", selection: Binding(
                                get: { store.filter.propertyType },
                                set: { store.filter.propertyType = $0 }
                            )) {
                                Text("Any").tag(Listing.PropertyType?.none)
                                ForEach(Listing.PropertyType.allCases, id: \.self) { type in
                                    Text(type.rawValue.capitalized).tag(Optional(type))
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
        }
        .onAppear {
            Task {
                await store.fetchListings()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch store.listingsState {
        case .success:
            ListingsContentView(listings: store.visibleListings)
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
    ListingsView()
        .environment(ListingsStore(service: FixtureListingService(delay: .zero)))
        .environmentObject(FavouritesStore())
}
