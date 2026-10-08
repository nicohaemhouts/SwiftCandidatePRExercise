import SwiftUI

struct SavedListingsView: View {
    @Environment(ListingsStore.self) private var store
    @ObservedObject var favourites = FavouritesStore()

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(store.listings.filter { favourites.ids.contains($0.id) }) { listing in
                        NavigationLink(destination: ListingDetailView(listing: listing)) {
                            ListingRow(listing: listing)
                        }
                    }
                } header: {
                    Text(String(format: "%d saved", favourites.ids.count))
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(NSLocalizedString("saved_listings_title", comment: ""))
            .overlay {
                if favourites.ids.isEmpty {
                    ContentUnavailableView(
                        "No saved listings",
                        systemImage: "heart",
                        description: Text("Tap the heart on a listing to save it here.")
                    )
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
