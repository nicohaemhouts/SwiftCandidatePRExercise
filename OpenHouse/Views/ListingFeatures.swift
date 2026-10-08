import SwiftUI

struct ListingFeatures: View {
    let bedrooms: Int
    let bathrooms: Int
    let parking: Int

    var body: some View {
        HStack(spacing: 12) {
            Label("\(bedrooms)", systemImage: "bed.double")
                .accessibilityLabel(Text("^[\(bedrooms) bedroom](inflect: true)"))
            Label("\(bathrooms)", systemImage: "shower")
                .accessibilityLabel(Text("^[\(bathrooms) bathroom](inflect: true)"))
            Label("\(parking)", systemImage: "car")
                .accessibilityLabel(Text("^[\(parking) parking space](inflect: true)"))
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
}
