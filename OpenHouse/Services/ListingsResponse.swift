struct ListingsResponse: Decodable, Sendable {
    let listings: [Listing]
}
