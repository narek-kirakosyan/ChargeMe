//
//  EvanMapper.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 17.08.25.
//

import Foundation

extension EvanStation {
    func toDomain() -> ChargingStation {
        ChargingStation(
            id: id,
            provider: .evan,
            name: name,
            latitude: latitude,
            longitude: longitude,
            isAvailable: status == "available"
        )
    }
}
