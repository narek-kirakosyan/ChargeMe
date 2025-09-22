//
//  CircleButton.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 07.08.25.
//

import SwiftUI

struct CircleButton: View {
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
    }
}

#Preview {
    CircleButton(icon: "", action: {})
}
