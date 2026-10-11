import SwiftUI

struct AgentCard: View {
    let agent: Agent

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: agent.photoURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .fill(.quaternary)
            }
            .frame(width: 56, height: 56)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(agent.name)
                    .font(.headline)
                Text(agent.agency)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button {
                UIApplication.shared.open(URL(string: "tel:\(agent.phone)")!)
            } label: {
                Image(systemName: "phone.fill")
                    .font(.title3)
                    .padding(10)
                    .background(Color(red: 0.2, green: 0.45, blue: 0.95))
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
