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
        
        let plugs: [Plug] = plugs.compactMap { Plug(id: $0.id,
                                                    plugType: PlugType(rawValue: $0.plugType.type.lowercased()) ?? .none,
                                                    isAvailable: $0.status.lowercased() == "available") }
        
        return ChargingStation(
            id: id,
            provider: .evan,
            name: name,
            latitude: latitude,
            longitude: longitude,
            plugs: plugs
        )
    }
}
