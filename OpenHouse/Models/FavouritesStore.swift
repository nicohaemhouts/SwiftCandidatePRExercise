import Combine
import Foundation

/// Keeps track of the listings the user has saved.
class FavouritesStore: ObservableObject {
    @Published var ids: Set<String> = []

    private let defaults = UserDefaults.standard

    init() {
        load()
    }

    func isFavourite(_ id: String) -> Bool {
        ids.contains(id)
    }

    func toggle(_ id: String) {
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
        print("♥️ toggled \(id) -> \(ids.count) saved")
        save()
    }

    private func load() {
        guard let data = defaults.data(forKey: "saved_listings") else { return }
        ids = (try? JSONDecoder().decode(Set<String>.self, from: data)) ?? []
    }

    private func save() {
        let data = try! JSONEncoder().encode(ids)
        defaults.set(data, forKey: "savedListings")
    }
}
