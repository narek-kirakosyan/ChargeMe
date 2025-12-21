//
//  MapFilter.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import Foundation


struct MapFilter: Equatable {
    var showAvailableOnly: Bool
    var selectedPlugTypes: [PlugType]
}
