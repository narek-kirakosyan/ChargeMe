//
//  ProfileScreen.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 21.12.25.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        VStack(spacing: 12) {
            image
            name
            account
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private var image: some View {
        Image(systemName: "person.crop.circle")
            .resizable()
            .frame(width: 200, height: 200)
            .foregroundStyle(.dsGreen)
    }
    
    private var name: some View {
        VStack {
            Text("Ethan Carter")
                .font(.title)
            Text("Member since 2025")
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
    
    private var account: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Account")
                .font(.title)
            ProfileCell(image: Image(systemName: "person.crop.circle"),
                        title: "Personal Details",
                        subtitle: "ethancarter@example.com")
            ProfileCell(image: Image(systemName: "creditcard"),
                        title: "Payment Methods")
            ProfileCell(image: Image(systemName: "car"),
                        title: "Vehicle",
                        subtitle: "Tesla Model 3")
            ProfileCell(image: Image(systemName: "clock"),
                        title: "Charging History")
        }
    }
}

#Preview {
    NavigationView {
        ProfileScreen()
    }
}
