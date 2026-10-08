struct ListingFilter {
    enum Sort: CaseIterable {
        case newest
        case priceLowToHigh
        case priceHighToLow

        var title: String {
            switch self {
            case .newest: return "Newest"
            case .priceLowToHigh: return "Price: low to high"
            case .priceHighToLow: return "Price: high to low"
            }
        }
    }

    var propertyType: Listing.PropertyType?
    var sort: Sort = .newest
    var query: String = ""
}
