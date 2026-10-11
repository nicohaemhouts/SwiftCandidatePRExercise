import Foundation

struct Agent: Hashable, Sendable, Decodable {
    let name: String
    let agency: String
    let phone: String
    let photoURL: URL?

    private enum CodingKeys: String, CodingKey {
        case name, agency, phone
        case photoURL = "photo_url"
    }
}
