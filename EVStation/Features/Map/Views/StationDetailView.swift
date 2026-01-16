import SwiftUI

struct StationDetailView: View {
    let station: ChargingStation
    @Environment(\.dismiss) var dismiss  // ✅

    var body: some View {
                VStack(alignment: .leading) {
                    Image(.stationDetails)
                        .resizable()
                        .frame(height: 280)
                        .scaledToFit()
                    VStack(alignment: .leading,spacing: 12) {
                        HStack {
                            Text(station.provider.rawValue + " Station")
                                .font(.title)
                                .bold()
                            Spacer()
                            icon
                        }

                        Text(station.name)
                            .font(.body)
                            .foregroundStyle(.gray)
                        plugs
                        buttons
                    }
                    .padding(.horizontal, 12)
                    Spacer()
                }
            .navigationTitle("Station Details")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var icon: some View {
        ZStack {
            Circle()
                .fill(statusColor(for: station))
                .frame(width: 40, height: 40)
                .shadow(radius: 3)

            Image(systemName: "bolt.fill")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
        }
    }
    
    private func statusColor(for station: ChargingStation) -> Color {
        .red
//        station.plugs.map { $0.isAvailable } ? .green : .red
    }
    
    private var plugs: some View {
        Form {
            Section("Plugs") {
                ForEach(groupedPlugs, id: \.type) { item in
                    HStack(spacing: 12) {
                        Image(systemName: item.type.icon)
                            .frame(width: 24)

                        Text(item.type.title)

                        Spacer()

                        Text("\(item.count) \(item.count == 1 ? "charger" : "chargers")")
                            .foregroundStyle(.secondary)
                    }
                    .frame(height: 52)
                }
            }
        }
    }
    
    private var buttons: some View {
        HStack {
            Button(action: {  }) {
                Text("Directions")
            }
            .buttonStyle(.primary)
            Spacer()
            Button(action: {  }) {
                Text("Start Charging")
            }
            .buttonStyle(.primary)
        }
        .padding()
    }
    
    private var groupedPlugs: [(type: PlugType, count: Int)] {
        Dictionary(grouping: station.plugs, by: { $0.plugType })
            .map { (type: $0.key, count: $0.value.count) }
            .sorted { $0.type.title < $1.type.title }
    }
}

#Preview {
    NavigationView {
        StationDetailView(station: ChargingStation(provider: .evan, name: "Alek Manukyan", latitude: 1111, longitude: 1111, plugs: []))
    }
}
