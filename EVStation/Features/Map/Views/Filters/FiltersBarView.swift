//
//  FiltersBarView.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import SwiftUI

struct FiltersBarView: View {
    @Binding var filters: MapFilter

    let filterOptions: [FilterOption] = [
        FilterOption(icon: "bolt.fill", title: "CCS"),
        FilterOption(icon: "bolt.circle", title: "CHAdeMO"),
        FilterOption(icon: "leaf.fill", title: "Type 2")
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(filterOptions, id: \.title) { option in
                    VStack(spacing: 6) {
                        ZStack {
                            Circle()
                                .fill(filters.selectedPlugTypes.contains(option.title) ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                            Image(systemName: option.icon)
                                .foregroundColor(.white)
                                .font(.headline)
                        }

                        Text(option.title)
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    .onTapGesture {
                        toggle(option: option.title)
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

    private func toggle(option: String) {
        if filters.selectedPlugTypes.contains(option) {
            filters.selectedPlugTypes.removeAll { $0 == option }
        } else {
            filters.selectedPlugTypes.append(option)
        }
    }

    struct FilterOption {
        let icon: String
        let title: String
    }
}

#Preview {
    FiltersBarView(filters: .constant(MapFilter(showAvailableOnly: true, selectedPlugTypes: [""])))
}
