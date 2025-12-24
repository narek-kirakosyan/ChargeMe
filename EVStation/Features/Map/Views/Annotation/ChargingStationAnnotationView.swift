//
//  ChargingStationAnnotationView.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import SwiftUI

struct ChargingStationAnnotationView: View {
    let station: ChargingStation
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    Circle()
                        .fill(statusColor(for: station))
                        .frame(width: 40, height: 40)
                        .shadow(radius: 3)

                    Image(systemName: "bolt.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }

                Text(shortName(for: station.name))
                    .font(.caption2)
                    .bold()
                    .padding(4)
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(6)
            }
        }
        .buttonStyle(.plain)
    }

    private func statusColor(for station: ChargingStation) -> Color {
        station.isAvailable ? .green : .red
    }

    private func shortName(for fullName: String) -> String {
        let components = fullName.split(separator: " ")
        return components.first.map { String($0.prefix(6)) } ?? fullName
    }
}

#Preview {
    ChargingStationAnnotationView(
            station: ChargingStation(
                provider: .evan,
                name: "FastCharge Yerevan",
                latitude: 40.1772,
                longitude: 44.5035,
                isAvailable: true,
                plugTypes: [.tesla]
            ),
            action: {}
        )
}
