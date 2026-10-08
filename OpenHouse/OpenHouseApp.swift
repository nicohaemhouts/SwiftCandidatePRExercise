import SwiftUI

@main
struct OpenHouseApp: App {
    private let listingService = AppEnvironment.makeListingService()

    var body: some Scene {
        WindowGroup {
            ListingsView(service: listingService)
        }
    }
}
