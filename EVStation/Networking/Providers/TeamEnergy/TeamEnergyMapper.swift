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
            isAvailable: available,
            plugTypes: [.tesla]
        )
    }
}

extension TeamEnergyStationData {
    func toDomain() -> ChargingStation {
        let plugTypesMatrix = chargePointInfos.map { $0.connectors.map { $0.connectorType.components(separatedBy: " / ") } }.flatMap { $0 }
        let plugTypes = plugTypesMatrix.flatMap { $0 }.compactMap { PlugType(rawValue: $0.lowercased()) }
        return ChargingStation(
            id: UUID().uuidString,
            provider: .teamEnergy,
            name: name,
            latitude: latitude,
            longitude: longitude,
            isAvailable: true,
            plugTypes: plugTypes
        )
    }
}
