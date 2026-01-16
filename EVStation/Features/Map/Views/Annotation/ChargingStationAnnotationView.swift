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
                icon
                    .frame(width: 32, height: 32)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var icon: Image {
        let availables = station.plugs.map { $0.isAvailable }
        if availables.allSatisfy({ $0 == false }) {
            return Image(.mapRed)
        } else if availables.allSatisfy({ $0 == true }) {
            return Image(.mapGreen)
        }
        return Image(.mapYellow)
    }
}

#Preview {
    ChargingStationAnnotationView(
            station: ChargingStation(
                provider: .evan,
                name: "FastCharge Yerevan",
                latitude: 40.1772,
                longitude: 44.5035,
                plugs: [Plug(id: "", plugType: .ccs1, isAvailable: false),
                        Plug(id: "", plugType: .ccs1, isAvailable: true),
                        Plug(id: "", plugType: .ccs1, isAvailable: false),
                        Plug(id: "", plugType: .ccs1, isAvailable: false)]
            ),
            action: {}
        )
}
