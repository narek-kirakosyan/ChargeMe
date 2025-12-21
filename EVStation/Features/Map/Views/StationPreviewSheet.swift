//
//  StationPreviewSheet.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import SwiftUI

struct StationPreviewSheet: View {
    let station: ChargingStation
    var onExpand: () -> Void
    var onDismiss: () -> Void

    var body: some View {
        VStack {
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 8)

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(station.name)
                        .font(.headline)
                    Text(station.provider.rawValue)
                        .font(.headline)
                    Text("Tap to see details")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .onTapGesture {
                onExpand()
            }
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.bottom, 20)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut, value: station.id)
    }
}

#Preview {
    StationPreviewSheet(station: ChargingStation(id: UUID().uuidString, provider: .evan, name: "", latitude: 0, longitude: 0, isAvailable: true, plugTypes: [.tesla]), onExpand: {}, onDismiss: {})
}
