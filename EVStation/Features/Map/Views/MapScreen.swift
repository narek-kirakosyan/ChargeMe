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
            map
            floatingButtons
            if let station = selectedStation {
                stationPreviewSheet(station: station)
            }
            if showFilters {
                filters
            }
        }
        .onLoad {
            viewModel.loadStations(using: modelContext)
        }

        // Filters full sheet
        .sheet(isPresented: $showFiltersSheet) {
            MapFiltersScreen(
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
    
    private var map: some View {
        Map(position: $mapCameraPosition, interactionModes: .all) {
            UserAnnotation()
            ForEach(viewModel.filteredStations) { station in
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
    }
    
    private var floatingButtons: some View {
        VStack(spacing: 16) {
                CircleButton(icon: "slider.horizontal.3") {
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
    }
    
    private func stationPreviewSheet(station: ChargingStation) -> some View {
        StationPreviewSheet(
            station: station,
            onExpand: {
                coordinator.goToStationDetail(station)
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
    
    private var filters: some View {
        FiltersBarView(filters: $viewModel.filters) {
            viewModel.applyFilters()
        }
            .padding(.bottom, 20)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    MapScreen()
}
