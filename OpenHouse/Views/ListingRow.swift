import SwiftUI

struct ListingRow: View {
    let listing: Listing

    @EnvironmentObject private var favourites: FavouritesStore
    @Environment(\.toggleFavourite) private var toggleFavourite
    @Environment(\.priceFormatter) private var priceFormatter
    @Environment(\.listingStatusStyle) private var statusStyle
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        switch listing.status {
        case .forSale:
            content
        case .underOffer:
            content
                .overlay(alignment: statusStyle.badgePlacement) {
                    StatusBadge(title: "Under offer", tint: Color(red: 0.98, green: 0.80, blue: 0.08))
                }
        case .sold:
            content
                .opacity(statusStyle.dimsSold ? 0.6 : 1)
                .overlay(alignment: statusStyle.badgePlacement) {
                    StatusBadge(title: "Sold", tint: .red)
                }
        }
    }

    private var content: some View {
        HStack(alignment: .top, spacing: 12) {
            ListingThumbnail(url: listing.imageURL)

            VStack(alignment: .leading, spacing: 4) {
                Text(priceFormatter.string(from: NSNumber(value: listing.price)) ?? "")
                    .font(.headline)
                Text(listing.address)
                    .font(.body)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                Text(listing.suburb)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                ListingFeatures(
                    bedrooms: listing.bedrooms,
                    bathrooms: listing.bathrooms,
                    parking: listing.parking
                )
            }

            Spacer()

            Button {
                toggleFavourite(listing.id)
            } label: {
                Image(systemName: favourites.isFavourite(listing.id) ? "heart.fill" : "heart")
                    .foregroundStyle(
                        favourites.isFavourite(listing.id) ? AnyShapeStyle(.red) : AnyShapeStyle(.secondary)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

struct StatusBadge: View {
    let title: LocalizedStringKey
    let tint: Color

    var body: some View {
        Text(title)
            .textCase(.uppercase)
            .font(.system(size: 11, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(tint)
            .cornerRadius(4)
    }
}
