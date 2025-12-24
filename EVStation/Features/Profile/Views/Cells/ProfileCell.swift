//
//  ProfileCell.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 21.12.25.
//

import SwiftUI

struct ProfileCell: View {
    let image: Image
    let title: String
    var subtitle: String? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 44, height: 44)
                image
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                if let subtitle {
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    ProfileCell(image: Image(systemName: "person.crop.circle"),
                title: "Personal Details",
                subtitle: "ethancarter@example.com")
}
