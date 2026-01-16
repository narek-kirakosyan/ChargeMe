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
            plugs: []
        )
    }
}

extension TeamEnergyStationData {
    func toDomain() -> ChargingStation {
        let connectors: [Connector] = chargePointInfos.map { $0.connectors }.flatMap { $0 }
        let plugTypesMatrix = connectors.map { $0.connectorType.components(separatedBy: " / ") }
        let plugTypes = plugTypesMatrix.flatMap { $0 }.compactMap { PlugType(rawValue: $0.lowercased()) }
        let plugs = connectors.map { Plug(id: $0.connectorId, plugType: plugTypes.first ?? .tesla, isAvailable: $0.status == "1") }
        return ChargingStation(
            id: UUID().uuidString,
            provider: .teamEnergy,
            name: name,
            latitude: latitude,
            longitude: longitude,
            plugs: plugs
        )
    }
}
