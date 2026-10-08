import SwiftUI

struct ListingsErrorView: View {
    let retry: () async -> Void

    var body: some View {
        ContentUnavailableView {
            Label("Couldn't load listings", systemImage: "wifi.exclamationmark")
        } description: {
            Text("Check your connection and try again.")
        } actions: {
            Button("Retry") {
                Task { await retry() }
            }
        }
    }
}
