//
//  FavoritesCell.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 22.12.25.
//

import SwiftUI
import MapKit

enum MapApp {
    case yandex
    case google
    case apple
    
    var title: String {
        switch self {
        case .yandex:
            return "Yandex Navi"
        case .google:
            return "Google Maps"
        case .apple:
            return "Apple Maps"
        }
    }
    
    func urlString(lat: Double, long: Double) -> String {
        return switch self {
        case .yandex:
            "yandexnavi://build_route_on_map?lat_to=\(lat)&lon_to=\(long)"
        case .google:
            "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving"
        case .apple:
            "maps.apple.com\(lat),\(long)&dirflg=d"
        }
    }
}

struct FavoritesCell: View {
    @State var isSheetPresented = false
    let station: ChargingStation
    
    var body: some View {
        HStack {
            content
            Spacer()
            directionButton
            Image(systemName: "heart")
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
        .padding(12)
        .background(.gray)
        .cornerRadius(8)
        .confirmationDialog("", isPresented: $isSheetPresented, titleVisibility: .hidden, actions: {
            appButton(type: .yandex)
            appButton(type: .google)
            appButton(type: .apple)
            copyButton
        })
//        .sheet(isPresented: $isSheetPresented) {
//            VStack(alignment: .leading) {
//                appButton(type: .yandex)
//                Divider()
//                appButton(type: .google)
//                Divider()
//                appButton(type: .apple)
//            }
//            .padding(30)
//            .font(.largeTitle)
//            .presentationDetents([.height(240)])
//        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(station.provider.rawValue)
            Text(station.name)
            Text(station.plugTypes.map { $0.rawValue }.joined(separator: ","))
        }
    }
    
    var directionButton: some View {
        Button {
            isSheetPresented = true
        } label: {
            Image(systemName: "arrow.trianglehead.turn.up.right.circle")
        }
    }
    
    func appButton(type: MapApp) -> some View {
        Button {
            openMaps(for: type)
        } label: {
            Text(type.title)
        }
    }
    
    var copyButton: some View {
        Button {
            copyToClipboard()
        } label: {
            Text("Copy Address")
        }
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = "\(station.latitude)/\(station.longitude)"
    }
    
    func openMaps(for type: MapApp) {
        if type == .apple {
            openInAppleMaps()
        } else {
            if let url = URL(string: type.urlString(lat: station.latitude, long: station.longitude)), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func openInAppleMaps() {
        let coords = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
        let placemark = MKPlacemark(coordinate: coords)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(coords.latitude)/\(coords.latitude)"

        // This opens the native Maps app directly
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

#Preview {
    FavoritesCell(station: ChargingStation(
        provider: .evan,
        name: "FastCharge Yerevan",
        latitude: 40.1772,
        longitude: 44.5035,
        isAvailable: true,
        plugTypes: [.tesla]
    ))
}
