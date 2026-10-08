protocol ListingProviding: Sendable {
    func fetchListings() async throws -> [Listing]
}

enum ListingServiceError: Error {
    case badResponse(statusCode: Int)
    case fixtureMissing
}
