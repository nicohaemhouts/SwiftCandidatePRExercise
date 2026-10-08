# OpenHouse

A small SwiftUI app that fetches property listings as JSON and shows them in a list with a detail screen.

## Running

Open `OpenHouse.xcodeproj` and run the `OpenHouse` scheme. The scheme passes `-UseFixtures`, which serves the bundled `listings.json` instead of calling the live API.

## Structure

- `Models/` – value types decoded from the API, plus the `ListingsStore` that owns the loaded data and its `LoadState`.
- `Services/` – `ListingProviding` and its live and fixture implementations. Views never call the network directly.
- `Views/` – `ListingsView` switches over the store's state (skeleton / content / error) and the content views are pure rendering.
- `OpenHouseTests/` – Swift Testing suite for the store, using stubbed services.
