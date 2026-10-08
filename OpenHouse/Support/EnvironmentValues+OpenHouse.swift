import SwiftUI

extension EnvironmentValues {
    /// Toggles a listing in the favourites store.
    @Entry var toggleFavourite: (String) -> Void = { _ in }

    /// Shared formatter for prices so rows don't each create one.
    @Entry var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_AU")
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    /// How status badges are drawn on rows.
    @Entry var listingStatusStyle = ListingStatusStyle(badgePlacement: .topTrailing, dimsSold: true)
}

struct ListingStatusStyle {
    let badgePlacement: Alignment
    let dimsSold: Bool
}
