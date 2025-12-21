import Foundation
import SwiftData
import CoreLocation

enum ChargingStationProvider: String, Codable {
    case evan = "Evan"
    case teamEnergy = "Team Energy"
}

enum PlugType: String, Identifiable, CaseIterable, Codable {
    case type1 = "type 1"
    case type2 = "type 2"
    case tesla = "tesla"
    case gbtac = "gb/t ac"
    case gbtdc = "gb/t dc"
    case ccs1 = "ccs1"
    case ccs2 = "ccs2"
    
    var id: Self {self}
    
    static var allCases: [PlugType] {
        [.type1, .type2, .tesla, .gbtac, .gbtdc, .ccs1, .ccs2]
    }
    
    var title: String {
        return switch self {
        case .type1:
            "Type 1"
        case .type2:
            "Type 2"
        case .tesla:
            "Tesla"
        case .gbtac:
            "GB/T AC"
        case .gbtdc:
            "GB/T DC"
        case .ccs1:
            "CCS1"
        case .ccs2:
            "CCS2"
        }
    }
    
    var icon: String {
        return switch self {
        case .type1:
            "ev.plug.ac.type.1"
        case .type2:
            "ev.plug.ac.type.2"
        case .tesla:
            "ev.plug.dc.nacs"
        case .gbtac:
            "ev.plug.ac.gb.t"
        case .gbtdc:
            "ev.plug.dc.gb.t"
        case .ccs1:
            "ev.plug.dc.ccs1"
        case .ccs2:
            "ev.plug.dc.ccs2"
        }
    }
}

@Model
final class ChargingStation {
    @Attribute(.unique) var id: String
    @Attribute var provider: ChargingStationProvider
    var name: String
    var latitude: Double
    var longitude: Double
    var isAvailable: Bool
    @Attribute var plugTypes: [PlugType]

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(
        id: String = UUID().uuidString,
        provider: ChargingStationProvider,
        name: String,
        latitude: Double,
        longitude: Double,
        isAvailable: Bool,
        plugTypes: [PlugType]
    ) {
        self.id = id
        self.provider = provider
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.isAvailable = isAvailable
        self.plugTypes = plugTypes
    }
}
