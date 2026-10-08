import Foundation

/// Serves the bundled `listings.json` after a short delay so loading states are visible.
struct FixtureListingService: ListingProviding {
    var delay: Duration = .milliseconds(800)

    func fetchListings() async throws -> [Listing] {
        try await Task.sleep(for: delay)

        guard let url = Bundle.main.url(forResource: "listings", withExtension: "json") else {
            throw ListingServiceError.fixtureMissing
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder.openHouse().decode(ListingsResponse.self, from: data).listings
    }
}
