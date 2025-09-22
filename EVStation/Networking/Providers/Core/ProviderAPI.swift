//
//  ProviderAPI.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 25.08.25.
//

import Foundation

protocol ProviderAPI {
    func fetchStations() async throws -> [ChargingStation]
    func refreshTokenIfNeeded() async throws
}
