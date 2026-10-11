import Foundation

final class Analytics {
    static let shared = Analytics()

    enum Event {
        case viewedListing(String)
        case toggledFavourite(String)
    }

    private var events: [Event] = []

    func track(_ event: Event) {
        events.append(event)
        #if DEBUG
        print("[analytics] \(event)")
        #endif
    }
}
