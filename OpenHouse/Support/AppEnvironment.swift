import Foundation

/// Picks the concrete services for this process.
///
/// Pass `-UseFixtures` as a launch argument (the shared scheme does) to run
/// against the bundled JSON instead of the live API.
enum AppEnvironment {
    static func makeListingService() -> any ListingProviding {
        if ProcessInfo.processInfo.arguments.contains("-UseFixtures") {
            return FixtureListingService()
        }
        return LiveListingService(baseURL: Configuration.apiBaseURL)
    }
}
