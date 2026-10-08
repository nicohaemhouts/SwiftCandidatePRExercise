import Foundation
@testable import OpenHouse

extension Listing {
    static func fixture(
        id: String = "L-1",
        price: Int = 1_250_000,
        status: Status = .forSale
    ) -> Listing {
        Listing(
            id: id,
            address: "12 Wattle Street",
            suburb: "Newtown NSW 2042",
            price: price,
            currencyCode: "AUD",
            bedrooms: 3,
            bathrooms: 2,
            parking: 1,
            propertyType: .house,
            status: status,
            imageURL: nil,
            listedAt: Date(timeIntervalSince1970: 1_758_000_000)
        )
    }
}
