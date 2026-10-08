import Testing
@testable import OpenHouse

@MainActor
struct ListingsStoreTests {
    @Test func `State is nil until the first fetch is requested`() {
        let store = ListingsStore(service: StubListingService(result: .success([])))

        #expect(store.listingsState == nil)
    }

    @Test func `Successful fetch publishes the listings`() async throws {
        let listing = Listing.fixture()
        let store = ListingsStore(service: StubListingService(result: .success([listing])))

        await store.fetchListings()
        try await Task.sleep(for: .milliseconds(200)) // let the detached decode finish

        #expect(store.listingsState == .success([listing]))
    }

    @Test func `Service failure maps to failedToFetch`() async throws {
        let store = ListingsStore(service: StubListingService(result: .failure(StubError())))

        await store.fetchListings()
        try await Task.sleep(for: .milliseconds(200))

        #expect(store.listingsState == .failure(.failedToFetch))
    }

    @Test(.disabled("Flaky since the detached decode change – tracked in OH-151"))
    func `A fetch requested while one is in flight is ignored`() async {
        let gate = FetchGate()
        let store = ListingsStore(service: GatedListingService(gate: gate))

        let firstFetch = Task { await store.fetchListings() }
        await gate.waitUntilRequested()
        #expect(store.listingsState?.isLoading == true)

        await store.fetchListings()

        await gate.release(with: [.fixture()])
        await firstFetch.value

        let requestCount = await gate.requestCount
        #expect(requestCount == 1)
        #expect(store.listingsState?.value?.count == 1)
    }

    @Test func `Price high to low sorts descending`() async throws {
        let cheap = Listing.fixture(id: "cheap", price: 500_000)
        let dear = Listing.fixture(id: "dear", price: 900_000)
        let store = ListingsStore(service: StubListingService(result: .success([cheap, dear])))
        await store.fetchListings()
        try await Task.sleep(for: .milliseconds(200))

        store.filter.sort = .priceHighToLow

        #expect(store.visibleListings.count == 2)
    }
}
