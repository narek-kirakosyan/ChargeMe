import SwiftUI

struct MapTabView: View {
    @EnvironmentObject var mapCoordinator: MapCoordinator
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationStack(path: $mapCoordinator.path) {
            MapScreen()
                .navigationDestination(for: MapRoute.self) { route in
                    switch route {
                    case .stationDetail(let station):
                        StationDetailView(station: station)
                    }
                }
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
}
