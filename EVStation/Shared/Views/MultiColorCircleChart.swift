//
//  MultiColorCircleChart.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 08.01.26.
//

import SwiftUI
import Charts // 1. Import the Charts framework

// 2. Define your data model
struct CategoryData: Identifiable, Equatable {
    let id = UUID()
    let color: Color
}

struct MultiColorCircleChart: View {
    let plugs: [Plug]
    // Sample data
    
    var chartData: [CategoryData] {
        var tmp = [CategoryData]()
        plugs.forEach {
            if $0.isAvailable {
                tmp.append(.init(color: .softGreen))
            } else {
                tmp.insert(.init(color: .blue), at: 0)
            }
        }
        return tmp
    }
    
    var body: some View {
        Chart(Array(chartData.enumerated()), id: \.element.id) { index, element in
            // 3. Use SectorMark to define the slices
             SectorMark(
                angle: .value("Value", 20),
                innerRadius: 8, // Optional: creates a donut chart
                outerRadius: 20,
                angularInset: angularInset(at: index)
            )
            .foregroundStyle(element.color) // Color the slices
            .annotation(position: .overlay) { // Add labels
            }
        }
    }
    
    private func angularInset(at index: Int) -> CGFloat {
        guard index + 1 < chartData.count else { return 0 }
        
        let currentColor = chartData[index].color
        let previousColor = chartData[index + 1].color
        
        return currentColor == previousColor ? 0 : 12
    }
}

// Preview
#Preview {
    MultiColorCircleChart(plugs: [Plug(id: "", plugType: .ccs1, isAvailable: true),
                                  Plug(id: "", plugType: .ccs1, isAvailable: true),
                                  Plug(id: "", plugType: .ccs1, isAvailable: true),
                                  Plug(id: "", plugType: .ccs1, isAvailable: false)])
}
