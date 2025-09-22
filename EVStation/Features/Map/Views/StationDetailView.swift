import SwiftUI

struct StationDetailView: View {
    let station: ChargingStation
    @Environment(\.dismiss) var dismiss  // ✅

    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(station.name)
                        .font(.largeTitle)
                        .bold()

                    Text("Latitude: \(station.latitude)")
                    Text("Longitude: \(station.longitude)")

                    // Add more info here
                }
                .padding()
            }
            .navigationTitle("Station Details")
    }
}

#Preview {
    StationDetailView(station: ChargingStation(provider: .evan, name: "Station", latitude: 1111, longitude: 1111, isAvailable: true))
}
