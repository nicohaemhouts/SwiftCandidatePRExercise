import Testing
@testable import OpenHouse

@MainActor
struct ListingsStoreTests {
    @Test func `State is nil until the first fetch is requested`() {
        let store = ListingsStore(service: StubListingService(result: .success([])))

        #expect(store.listingsState == nil)
    }

    @Test func `Successful fetch publishes the listings`() async {
        let listing = Listing.fixture()
        let store = ListingsStore(service: StubListingService(result: .success([listing])))

        await store.fetchListings()

        #expect(store.listingsState == .success([listing]))
    }

    @Test func `Service failure maps to failedToFetch`() async {
        let store = ListingsStore(service: StubListingService(result: .failure(StubError())))

        await store.fetchListings()

        #expect(store.listingsState == .failure(.failedToFetch))
    }

    @Test func `A fetch requested while one is in flight is ignored`() async {
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
}
