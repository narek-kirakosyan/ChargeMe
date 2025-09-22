//
//  TeamEnergyMapper.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 25.08.25.
//

import Foundation

extension TeamEnergyStationDTO {
    func toDomain() -> ChargingStation {
        ChargingStation(
            id: stationId,
            provider: .teamEnergy,
            name: displayName,
            latitude: latitude,
            longitude: longitude,
            isAvailable: available
        )
    }
}

extension TeamEnergyStationData {
    func toDomain() -> ChargingStation {
        ChargingStation(
            id: UUID().uuidString,
            provider: .teamEnergy,
            name: name,
            latitude: latitude,
            longitude: longitude,
            isAvailable: true
        )
    }
}
