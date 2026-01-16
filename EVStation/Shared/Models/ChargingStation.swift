import Foundation
import SwiftData
import CoreLocation



@Model
final class ChargingStation {
    @Attribute(.unique) var id: String
    @Attribute var provider: ChargingStationProvider
    var name: String
    var latitude: Double
    var longitude: Double
    var plugs: [Plug] = []

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(
        id: String = UUID().uuidString,
        provider: ChargingStationProvider,
        name: String,
        latitude: Double,
        longitude: Double,
        plugs: [Plug]
    ) {
        self.id = id
        self.provider = provider
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.plugs = plugs
    }
}
