//
//  MapViewModel.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import SwiftUI
import SwiftData

@MainActor
final class MapViewModel: ObservableObject {
    @Published var stations: [ChargingStation] = []
    @Published var filters = MapFilter(showAvailableOnly: false, selectedPlugTypes: [])

    func loadStations(using context: ModelContext) {
        Task {
            stations = try await ProviderManager.shared.fetchAllStations()
        }
        return
        
        let descriptor = FetchDescriptor<ChargingStation>()

        do {
            let results = try context.fetch(descriptor)

            // Only insert mock data if empty
            if results.isEmpty {
                insertMockStations(into: context)
                stations = try context.fetch(descriptor) // Fetch again after inserting
            } else {
                stations = results
            }
        } catch {
            print("⚠️ Failed to load stations: \\(error)")
        }
    }
    
    func applyFilters() {
        var filtered = stations

        // Filter by availability
        if filters.showAvailableOnly {
            filtered = filtered.filter { $0.isAvailable }
        }

        // Filter by selected plug types
        if !filters.selectedPlugTypes.isEmpty {
            filtered = filtered.filter { station in
                // Add your own logic to match plug types
                // For now, assume station.name contains plug type for demo
                filters.selectedPlugTypes.contains(where: { station.name.contains($0) })
            }
        }

        stations = filtered
    }

    private func insertMockStations(into context: ModelContext) {
        let mockStations = [
            ChargingStation(provider: .evan, name: "Evin North", latitude: 40.1811, longitude: 44.5136, isAvailable: true),
            ChargingStation(provider: .teamEnergy, name: "FastCharge Center", latitude: 40.1772, longitude: 44.5035, isAvailable: false),
            ChargingStation(provider: .evan, name: "WattEV Malatia", latitude: 40.1589, longitude: 44.4711, isAvailable: true)
        ]

        for station in mockStations {
            context.insert(station)
        }

        do {
            try context.save()
        } catch {
            print("⚠️ Failed to save mock data: \\(error)")
        }
    }
}
