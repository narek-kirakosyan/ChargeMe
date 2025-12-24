//
//  TripsScreen.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 21.12.25.
//

import SwiftUI
import MapKit

enum Vehicle: String, CaseIterable {
    case Tesla
    case Audi
    case BMW
    case Ford
}

struct TripsScreen: View {
    @State var destination: String = ""
    @State var selectedVehicle: Vehicle = .Audi
    
    @State private var mapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.1772, longitude: 44.5035),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var body: some View {
        VStack {
            Form {
                destinationBar
                vehicleChooser
            }
            .frame(maxWidth: .infinity, maxHeight: 160)
            VStack {
                map
                    .frame(maxWidth: .infinity, maxHeight: 160)
                Spacer()
                findButton
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .navigationTitle("Plan a trip")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var destinationBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Enter destination", text: $destination)
        }
    }
    
    private var vehicleChooser: some View {
        Picker("Select vehicle", selection: $selectedVehicle) {
            ForEach(Vehicle.allCases, id: \.self) { vehicle in
                Text(vehicle.rawValue)
            }
        }
        .pickerStyle(.menu)
    }
    
    private var map: some View {
        Map(position: $mapCameraPosition, interactionModes: .all) {
        }
    }
    
    private var findButton: some View {
        Button("Find charging stops") {
            
        }
        .buttonStyle(.primary)
    }
}

#Preview {
    TripsScreen()
}
