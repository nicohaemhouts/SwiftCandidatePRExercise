import Observation

enum ListingsError: Error, Equatable {
    case failedToFetch
}

/// Owns the listings data and its load state. One instance per screen that shows listings.
@MainActor
@Observable
final class ListingsStore {
    private(set) var listingsState: LoadState<[Listing], ListingsError>?

    private let service: any ListingProviding

    init(service: any ListingProviding) {
        self.service = service
    }

    func fetchListings() async {
        guard listingsState?.isLoading != true else { return }
        listingsState = .loading

        do {
            listingsState = .success(try await service.fetchListings())
        } catch {
            listingsState = .failure(.failedToFetch)
        }
    }
}
