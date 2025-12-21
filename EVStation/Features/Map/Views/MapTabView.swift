import SwiftUI

struct MapTabView: View {
    @EnvironmentObject var mapCoordinator: MapCoordinator
    @StateObject private var locationManager = LocationManager()
    @State private var showOnboarding = true

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
        .fullScreenCover(isPresented: $showOnboarding, content: {
            OnboardingView(showOnboarding: $showOnboarding)
        })
        .onAppear {
            locationManager.requestLocationPermission()
        }
    }
}
