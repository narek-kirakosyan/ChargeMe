//
//  MapFiltersSheet.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import SwiftUI

struct MapFiltersSheet: View {
    @Binding var filters: MapFilter
    
    var onApply: () -> Void

    var body: some View {
        Form {
            Toggle("Only Available", isOn: $filters.showAvailableOnly)

            Section(header: Text("Plug Types")) {
                ForEach(["CCS", "CHAdeMO", "Type 2"], id: \.self) { type in
                    Toggle(type, isOn: Binding(
                        get: { filters.selectedPlugTypes.contains(type) },
                        set: { isOn in
                            if isOn {
                                filters.selectedPlugTypes.append(type)
                            } else {
                                filters.selectedPlugTypes.removeAll { $0 == type }
                            }
                        }
                    ))
                }
            }

            Button("Apply") {
                onApply()
            }
        }
        .navigationTitle("Filters")
    }
}

#Preview {
    MapFiltersSheet(filters: .constant(MapFilter(showAvailableOnly: true, selectedPlugTypes: [""])), onApply: {})
}
