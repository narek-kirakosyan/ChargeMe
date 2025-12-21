//
//  EvanMapper.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 17.08.25.
//

import Foundation

extension EvanStation {
    func toDomain() -> ChargingStation {
        let plugAdapters = plugs.compactMap { $0.adapters.compactMap { $0.plugAdapterModel.outputPlugType.type.lowercased() }}.flatMap { $0 }
        
        let plugTypes = plugs.compactMap { PlugType(rawValue: $0.plugType.type.lowercased()) }
        var isAvailable = false

        for plug in plugs {
            if plug.status.lowercased() == "available" {
                isAvailable = true
                break
            }
        }
        
        return ChargingStation(
            id: id,
            provider: .evan,
            name: name,
            latitude: latitude,
            longitude: longitude,
            isAvailable: isAvailable,
            plugTypes: plugTypes
        )
    }
}
