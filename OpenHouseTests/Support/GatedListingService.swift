@testable import OpenHouse

/// Suspends every fetch until the test releases it, so tests can observe the in-flight state.
actor FetchGate {
    private(set) var requestCount = 0
    private var pendingFetches: [CheckedContinuation<[Listing], any Error>] = []
    private var requestObservers: [CheckedContinuation<Void, Never>] = []

    func fetch() async throws -> [Listing] {
        requestCount += 1
        requestObservers.forEach { $0.resume() }
        requestObservers.removeAll()

        return try await withCheckedThrowingContinuation { continuation in
            pendingFetches.append(continuation)
        }
    }

    /// Returns once at least one fetch has been requested.
    func waitUntilRequested() async {
        guard requestCount == 0 else { return }
        await withCheckedContinuation { continuation in
            requestObservers.append(continuation)
        }
    }

    func release(with listings: [Listing]) {
        pendingFetches.forEach { $0.resume(returning: listings) }
        pendingFetches.removeAll()
    }
}

struct GatedListingService: ListingProviding {
    let gate: FetchGate

    func fetchListings() async throws -> [Listing] {
        try await gate.fetch()
    }
}
