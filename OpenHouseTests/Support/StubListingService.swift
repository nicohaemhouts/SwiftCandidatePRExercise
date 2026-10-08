@testable import OpenHouse

struct StubError: Error {}

/// Returns a fixed result immediately.
struct StubListingService: ListingProviding {
    let result: Result<[Listing], StubError>

    func fetchListings() async throws -> [Listing] {
        try result.get()
    }
}
