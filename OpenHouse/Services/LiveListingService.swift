import Foundation

struct LiveListingService: ListingProviding {
    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func fetchListings() async throws -> [Listing] {
        let (data, response) = try await session.data(from: baseURL.appending(path: "listings"))

        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw ListingServiceError.badResponse(statusCode: http.statusCode)
        }

        return try JSONDecoder.openHouse().decode(ListingsResponse.self, from: data).listings
    }
}
