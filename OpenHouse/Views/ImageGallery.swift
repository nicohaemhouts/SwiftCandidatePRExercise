import SwiftUI

struct ImageGallery: View {
    let urls: [URL]

    var body: some View {
        TabView {
            ForEach(urls, id: \.self) { url in
                CachedAsyncImage(url: url)
            }
        }
        .tabViewStyle(.page)
        .aspectRatio(3 / 2, contentMode: .fit)
        .cornerRadius(12)
    }
}
