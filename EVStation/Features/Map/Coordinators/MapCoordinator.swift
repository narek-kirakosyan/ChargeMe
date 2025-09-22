import SwiftUI

final class MapCoordinator: ObservableObject {
    @Published var path: [MapRoute] = []

    func goToStationDetail(_ station: ChargingStation) {
        path.append(.stationDetail(station))
    }

    func reset() {
        path = []
    }
}
