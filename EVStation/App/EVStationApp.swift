//
//  EVStationApp.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 06.08.25.
//

import SwiftUI
import SwiftData

@main
struct EVStationApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .modelContainer(for: ChargingStation.self)
                .preferredColorScheme(.dark)
        }
    }
}
