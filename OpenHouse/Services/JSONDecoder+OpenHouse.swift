import Foundation

extension JSONDecoder {
    /// Decoder configured for the OpenHouse API (ISO 8601 dates).
    static func openHouse() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
