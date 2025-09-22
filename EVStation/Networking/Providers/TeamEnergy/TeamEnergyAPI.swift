//
//  TeamEnergyAPI.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 25.08.25.
//

import Foundation

final class TeamEnergyAPI: ProviderAPI {
    private let network: NetworkService

    init() {
        let auth = TeamEnergyAuth()
        let interceptor = DefaultAuthInterceptor(
            tokenKey: TeamEnergyAuth.tokenKey,
            refreshHandler: { try await auth.refreshToken() }
        )
        self.network = DefaultNetworkService(interceptor: interceptor)
    }

    // 🔑 Temporary login (automatic at app start)
    func login() async throws {
        guard TokenStorage.shared.load(for: TeamEnergyAuth.tokenKey) == nil else { return }
        var request = URLRequest(url: URL(string: "https://api.teamenergy.am/UserManagement/Login")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Temporary credentials
        let body = ["phoneNumber": "+37495040077", "password": "Nartekilarde3"]
        request.httpBody = try JSONEncoder().encode(body)

        let response: AuthResponse = try await network.request(request)

        TokenStorage.shared.save(token: response.accessToken, for: TeamEnergyAuth.tokenKey)
//        TokenStorage.shared.save(token: response.refreshToken, for: TeamEnergyAuth.refreshTokenKey)
    }
    
    func fetchStations() async throws -> [ChargingStation] {
        guard let token = TokenStorage.shared.load(for: TeamEnergyAuth.tokenKey),
              let url = URL(string: "https://api.teamenergy.am/ChargePoint/search") else {
            throw NSError(domain: "FetchFailed", code: 2)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")


        let body: [String: Any] = ["noLatest": 1]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let dtos: TeamEnergyStationResponse = try await network.request(request)
        return dtos.data.map { $0.toDomain() }
        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
//            throw NSError(domain: "FetchFailed", code: 2)
//        }
//
//        return data
    }

//    func fetchStations() async throws -> [ChargingStation] {
//        var request = URLRequest(url: URL(string: "https://api.teamenergy.am/ChargePoint/search")!)
//        request.httpMethod = "GET"
//
//        let dtos: [TeamEnergyStationDTO] = try await network.request(request)
//        return dtos.map { $0.toDomain() }
//    }

    func refreshTokenIfNeeded() async throws {
        _ = try await TeamEnergyAuth().refreshToken()
    }
}
