//
//  FiltersBarView.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import SwiftUI

struct FiltersBarView: View {
    @Binding var filters: MapFilter
    var onClick: () -> Void = { }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(PlugType.allCases) { type in
                    VStack(spacing: 6) {
                        ZStack {
                            Circle()
                                .fill(filters.selectedPlugTypes.contains(type) ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                            Image(systemName: type.icon)
                                .foregroundColor(.white)
                                .font(.headline)
                        }

                        Text(type.title)
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    .onTapGesture {
                        toggle(type: type)
                        onClick()
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 90)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .padding(.horizontal)
    }

    private func toggle(type: PlugType) {
        if filters.selectedPlugTypes.contains(type) {
            filters.selectedPlugTypes.removeAll { $0 == type }
        } else {
            filters.selectedPlugTypes.append(type)
        }
    }

    struct FilterOption {
        let icon: String
        let title: String
    }
}

#Preview {
    FiltersBarView(filters: .constant(MapFilter(showAvailableOnly: true, selectedPlugTypes: [PlugType]())))
}
