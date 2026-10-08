import SwiftUI

struct ListingSummary: View {
    let price: Int
    let currencyCode: String
    let address: String
    let suburb: String
    let listedAt: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(price, format: .currency(code: currencyCode).precision(.fractionLength(0)))
                .font(.title)
                .bold()
            Text(address)
                .font(.title3)
            Text(suburb)
                .foregroundStyle(.secondary)
            Text(
                "Listed \(listedAt, format: .dateTime.day().month().year())",
                comment: "Shown under the address. The variable is the date the listing went live."
            )
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
    }
}
