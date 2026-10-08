import SwiftUI

struct ListingDetailView: View {
    let listing: Listing

    @EnvironmentObject private var favourites: FavouritesStore
    @Environment(\.toggleFavourite) private var toggleFavourite
    @Environment(\.priceFormatter) private var priceFormatter

    var body: some View {
        let _ = Analytics.shared.track(.viewedListing(listing.id))

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                gallery
                header
                ListingFeatures(
                    bedrooms: listing.bedrooms,
                    bathrooms: listing.bathrooms,
                    parking: listing.parking
                )
                description
                inspections
                agentCard
            }
            .padding()
        }
        .navigationTitle(listing.suburb)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    toggleFavourite(listing.id)
                } label: {
                    Label("Save", systemImage: favourites.isFavourite(listing.id) ? "heart.fill" : "heart")
                }
            }
        }
    }

    private var gallery: some View {
        ImageGallery(urls: listing.imageURLs)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(priceFormatter.string(from: NSNumber(value: listing.price)) ?? "")
                .font(.title)
                .bold()
            Text(listing.address)
                .font(.title3)
                .if(listing.status == .sold) { $0.strikethrough() }
            Text(listing.suburb)
                .foregroundColor(.secondary)
            Text("Listed on " + listing.listedAt.formatted(date: .abbreviated, time: .omitted))
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }

    private var description: some View {
        Group {
            Text(listing.descriptionText)
        }
        .font(.body)
    }

    private var inspections: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Inspections")
                .font(.title2)
                .bold()

            if listing.inspections.isEmpty {
                Text("No inspections scheduled")
                    .foregroundColor(.secondary)
            } else {
                ForEach(listing.inspections.map { InspectionTime(date: $0) }) { inspection in
                    InspectionRow(inspection: inspection)
                }
            }
        }
    }

    private var agentCard: some View {
        AgentCard(agent: listing.agent)
    }
}

struct InspectionTime: Identifiable {
    let id = UUID()
    let date: Date
}

struct InspectionRow: View {
    let inspection: InspectionTime
    private let formattedDate: String

    init(inspection: InspectionTime) {
        self.inspection = inspection
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d MMM, h:mm a"
        formattedDate = formatter.string(from: inspection.date)
    }

    var body: some View {
        Label(formattedDate, systemImage: "calendar")
            .frame(height: 44)
    }
}

#Preview {
    NavigationStack {
        ListingDetailView(listing: Listing.loadingMocks[0])
    }
    .environmentObject(FavouritesStore())
}
