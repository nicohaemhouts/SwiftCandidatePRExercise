import Foundation

extension Listing {
    /// Plausibly sized placeholder rows for the redacted skeleton state.
    /// Redaction masks content but does not size it, so these values set the bar widths.
    static let loadingMocks: [Listing] = (0..<6).map { index in
        Listing(
            id: "placeholder-\(index)",
            address: "12 Placeholder Street",
            suburb: "Somewhere NSW 2000",
            price: 1_250_000,
            currencyCode: "AUD",
            bedrooms: 3,
            bathrooms: 2,
            parking: 1,
            propertyType: .house,
            status: .forSale,
            imageURL: nil,
            listedAt: Date(timeIntervalSince1970: 0)
        )
    }
}
