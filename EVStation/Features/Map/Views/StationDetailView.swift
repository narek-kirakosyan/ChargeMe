import SwiftUI

struct StationDetailView: View {
    let station: ChargingStation
    @Environment(\.dismiss) var dismiss  // ✅

    var body: some View {
                VStack(alignment: .leading) {
                    Image(.stationDetails)
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading,spacing: 12) {
                        Text(station.provider.rawValue)
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("Address:")
                            .font(.title)
                        Text(station.name)
                            .font(.body)
                            .foregroundStyle(.gray)
                        if station.isAvailable {
                            Text("Available")
                                .font(.title)
                                .foregroundStyle(.dsGreen)
                        } else {
                            Text("Not Available:")
                                .font(.title)
                                .foregroundStyle(.dsRed)
                        }
                        plugs

                    }
                    .padding(.horizontal, 12)
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .top)
            .navigationTitle("Station Details")
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
    
    private var groupedPlugs: [(type: PlugType, count: Int)] {
        Dictionary(grouping: station.plugTypes, by: { $0 })
            .map { (type: $0.key, count: $0.value.count) }
            .sorted { $0.type.title < $1.type.title }
    }
}

#Preview {
    StationDetailView(station: ChargingStation(provider: .evan, name: "Station", latitude: 1111, longitude: 1111, isAvailable: true, plugTypes: [.tesla, .ccs1, .ccs2]))
}
