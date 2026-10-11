import SwiftUI

@main
struct OpenHouseApp: App {
    private let listingService = AppEnvironment.makeListingService()

    @State private var listingsStore: ListingsStore
    @StateObject private var favourites = FavouritesStore()

    init() {
        _listingsStore = State(wrappedValue: ListingsStore(service: AppEnvironment.makeListingService()))
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                ListingsView()
                    .tabItem { Label("Listings", systemImage: "house") }
                SavedListingsView()
                    .tabItem { Label("Saved", systemImage: "heart") }
            }
            .environment(listingsStore)
            .environmentObject(favourites)
            .environment(\.toggleFavourite) { id in
                favourites.toggle(id)
                Analytics.shared.track(.toggledFavourite(id))
            }
        }
    }
}
