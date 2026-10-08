import Foundation

enum Configuration {
    /// In the real app this is read from the build configuration (xcconfig → Info.plist).
    static let apiBaseURL: URL = {
        guard let url = URL(string: "https://api.openhouse.example/v1") else {
            preconditionFailure("API base URL is not a valid URL")
        }
        return url
    }()
}
