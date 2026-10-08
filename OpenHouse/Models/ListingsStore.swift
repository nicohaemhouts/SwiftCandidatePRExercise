import Foundation
import Observation

enum ListingsError: Error, Equatable {
    case failedToFetch
}

/// Owns the listings data and its load state. Shared by the Listings and Saved tabs.
@Observable
final class ListingsStore {
    private(set) var listingsState: LoadState<[Listing], ListingsError>?
    var filter = ListingFilter()

    private let service: any ListingProviding

    init(service: any ListingProviding) {
        self.service = service
    }

    var listings: [Listing] {
        listingsState?.value ?? []
    }

    var visibleListings: [Listing] {
        var result = listings
        if let type = filter.propertyType {
            result = result.filter { $0.propertyType == type }
        }
        if !filter.query.isEmpty {
            result = result.filter { $0.address.contains(filter.query) || $0.suburb.contains(filter.query) }
        }
        switch filter.sort {
        case .newest:
            return result.sorted { $0.listedAt > $1.listedAt }
        case .priceLowToHigh:
            return result.sorted { $0.price < $1.price }
        case .priceHighToLow:
            return result.sorted { $0.price < $1.price }
        }
    }

    func fetchListings() async {
        listingsState = .loading

        // Decode off the main thread so scrolling stays smooth on large result sets.
        Task.detached(priority: .userInitiated) {
            do {
                let listings = try await self.service.fetchListings()
                self.listingsState = .success(listings)
            } catch {
                self.listingsState = .failure(.failedToFetch)
            }
        }
    }
}
