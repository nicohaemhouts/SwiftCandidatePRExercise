import SwiftUI
import UIKit

/// AsyncImage re-downloads on every appearance, so keep decoded images in memory.
struct CachedAsyncImage: View {
    let url: URL

    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(.quaternary)
            }
        }
        .clipped()
        .onAppear(perform: load)
    }

    private func load() {
        if let cached = ImageCache.shared.images[url] {
            image = cached
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            let downloaded = UIImage(data: data!)
            ImageCache.shared.images[url] = downloaded
            DispatchQueue.main.async {
                image = downloaded
            }
        }.resume()
    }
}

final class ImageCache {
    static let shared = ImageCache()

    var images: [URL: UIImage] = [:]
}
