//
//  ProviderManager.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 25.08.25.
//
import Foundation

final class ProviderManager {
    static let shared = ProviderManager()
    private init() {}

    private let evan = EvanAPI()
    private let teamEnergy = TeamEnergyAPI()

    func fetchAllStations() async throws -> [ChargingStation] {
        // Ensure login before fetching
        try? await evan.login()
        try? await teamEnergy.login()

        let evanStations = (try? await evan.fetchStations()) ?? []
        let teamStations = (try? await teamEnergy.fetchStations()) ?? []
        
        return evanStations + teamStations
    }
}
