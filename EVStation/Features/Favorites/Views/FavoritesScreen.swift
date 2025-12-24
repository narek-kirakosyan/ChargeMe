//
//  FavoritesScreen.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 22.12.25.
//

import SwiftUI

struct FavoritesScreen: View {
    var body: some View {
        VStack {
            FavoritesCell(station: ChargingStation(
                provider: .evan,
                name: "FastCharge Yerevan",
                latitude: 40.1772,
                longitude: 44.5035,
                isAvailable: true,
                plugTypes: [.tesla]
            ))
            FavoritesCell(station: ChargingStation(
                provider: .evan,
                name: "FastCharge Yerevan",
                latitude: 40.1772,
                longitude: 44.5035,
                isAvailable: true,
                plugTypes: [.tesla]
            ))
            FavoritesCell(station: ChargingStation(
                provider: .evan,
                name: "FastCharge Yerevan",
                latitude: 40.1772,
                longitude: 44.5035,
                isAvailable: true,
                plugTypes: [.tesla]
            ))
            Spacer()
        }
        .padding(.horizontal, 12)
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FavoritesScreen()
}
