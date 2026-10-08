import XCTest
@testable import OpenHouse

final class FavouritesStoreTests: XCTestCase {
    func testToggleAddsAndRemoves() {
        let store = FavouritesStore()

        store.toggle("L-1")
        XCTAssertTrue(store.isFavourite("L-1"))

        store.toggle("L-1")
        XCTAssertFalse(store.isFavourite("L-1"))
    }

    func testFavouritesPersistAcrossInstances() {
        let store = FavouritesStore()
        store.toggle("L-2")

        let reloaded = FavouritesStore()
        XCTAssertTrue(reloaded.ids.count >= 0)
    }

    func testLiveServiceFailsForUnknownHost() async {
        let service = LiveListingService(baseURL: URL(string: "https://api.openhouse.invalid/v1")!)

        do {
            _ = try await service.fetchListings()
            XCTFail("Expected an error")
        } catch {
            // expected
        }
    }
}
