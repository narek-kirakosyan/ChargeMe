//
//  TeamEnergyAuth.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 25.08.25.
//

import Foundation

final class TeamEnergyAuth {
    static let tokenKey = "teamenergy_token"
    static let refreshTokenKey = "teamenergy_refresh"

    private let network = DefaultNetworkService()

    func refreshToken() async throws -> String {
        guard let refreshToken = TokenStorage.shared.load(for: TeamEnergyAuth.refreshTokenKey) else {
            throw URLError(.userAuthenticationRequired)
        }

        var request = URLRequest(url: URL(string: "https://teamenergy.am/api/auth/refresh")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["refreshToken": refreshToken]
        request.httpBody = try JSONEncoder().encode(body)

        let response: TeamEnergyLoginResponse = try await network.request(request)

        TokenStorage.shared.save(token: response.accessToken, for: TeamEnergyAuth.tokenKey)
        TokenStorage.shared.save(token: response.refreshToken, for: TeamEnergyAuth.refreshTokenKey)

        return response.accessToken
    }
}
