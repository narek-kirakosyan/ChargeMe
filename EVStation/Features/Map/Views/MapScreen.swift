import SwiftUI
import MapKit

struct MapScreen: View {
    @EnvironmentObject var coordinator: MapCoordinator
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = MapViewModel()

    @State private var selectedStation: ChargingStation? = nil
    @State private var showStationDetail = false
    @State private var showFilters = true
    @State private var showFiltersSheet = false
    
    @State private var mapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.1772, longitude: 44.5035),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )

    var body: some View {
        ZStack(alignment: .bottom) {

            Map(position: $mapCameraPosition, interactionModes: .all) {
                UserAnnotation()
                ForEach(viewModel.stations) { station in
                    Annotation(station.name, coordinate: station.location) {
                        ChargingStationAnnotationView(station: station) {
                            selectedStation = station
                            withAnimation {
                                showFilters = false
                            }
                        }
                    }
                }
                UserAnnotation()
            }
            
            // Floating buttons
            VStack(spacing: 16) {
                    CircleButton(icon: "slider.horizontal.3") {
//                        let dummy = ChargingStation(name: "Test", latitude: 40.1772, longitude: 44.5035, isAvailable: true)
//                        coordinator.goToStationDetail(dummy)
                        showFiltersSheet = true
                    }
                CircleButton(icon: "location.fill") {
                    withAnimation {
                        mapCameraPosition = .region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 40.1772, longitude: 44.5035),  // or user location if available
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        ))
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

            if let station = selectedStation {
                StationPreviewSheet(
                    station: station,
                    onExpand: {
                        coordinator.goToStationDetail(station)
//                        showStationDetail = true
                    },
                    onDismiss: {
                        selectedStation = nil
                        withAnimation {
                            showFilters = true
                        }
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            if showFilters {
                FiltersBarView(filters: $viewModel.filters)
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            viewModel.loadStations(using: modelContext)
        }

        // Filters full sheet
        .sheet(isPresented: $showFiltersSheet) {
            MapFiltersSheet(
                filters: $viewModel.filters,
                onApply: {
                    viewModel.applyFilters()
                    showFiltersSheet = false
                }
            )
        }

        // Full-screen station detail
        .fullScreenCover(isPresented: $showStationDetail) {
            if let station = selectedStation {
                StationDetailView(station: station)
            }
        }
    }
}

#Preview {
    MapScreen()
}
