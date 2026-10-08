import Foundation

struct Listing: Identifiable, Hashable, Sendable, Decodable {
    enum PropertyType: String, Hashable, Sendable, Decodable, CaseIterable {
        case house
        case apartment
        case townhouse
    }

    enum Status: String, Hashable, Sendable, Decodable {
        case forSale = "for_sale"
        case underOffer = "under_offer"
        case sold
    }

    let id: String
    let address: String
    let suburb: String
    let price: Int
    let currencyCode: String
    let bedrooms: Int
    let bathrooms: Int
    let parking: Int
    let propertyType: PropertyType
    let status: Status
    let imageURL: URL?
    let imageURLs: [URL]
    let descriptionText: String
    let agent: Agent
    let inspections: [Date]
    let listedAt: Date

    private enum CodingKeys: String, CodingKey {
        case id, address, suburb, price, bedrooms, bathrooms, parking, status, agent, inspections
        case currencyCode = "currency_code"
        case propertyType = "property_type"
        case imageURL = "image_url"
        case imageURLs = "image_urls"
        case descriptionText = "description"
        case listedAt = "listed_at"
    }
}
