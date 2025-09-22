//
//  EvanAPI.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 17.08.25.
//

import Foundation

final class EvanAPI: ProviderAPI {
    private let network: NetworkService
    private let baseURL = URL(string: "https://evcharge-api-prod.e-evan.com/api")!

    init() {
        let auth = EvanAuth()
        let interceptor = DefaultAuthInterceptor(
            tokenKey: EvanAuth.tokenKey,
            refreshHandler: { try await auth.refreshToken() }
        )
        self.network = DefaultNetworkService(interceptor: interceptor)
    }
    
    func fetchStations() async throws -> [ChargingStation] {
        var comps = URLComponents(url: baseURL.appendingPathComponent("stations/stations"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            URLQueryItem(name: "limit", value: "\(50)"),
            URLQueryItem(name: "offset", value: "\(50)")
        ]

        guard let url = comps.url else {
            throw AuthTokenError.invalidToken
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dtos: StationsResponse = try await network.request(request)
        return dtos.data.stations.map { $0.toDomain() }
    }
    
    func refreshTokenIfNeeded() async throws {
        _ = try await EvanAuth().refreshToken()
    }
}

extension EvanAPI {
//    func login(username: String, password: String) async throws {
//        var request = URLRequest(url: URL(string: "https://evan.am/api/auth/login")!)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let body = EvanLoginRequest(username: username, password: password)
//        request.httpBody = try JSONEncoder().encode(body)
//        
//        let response: EvanLoginResponse = try await network.request(request)
//        
//        TokenStorage.shared.save(token: response.accessToken, for: EvanAuth.tokenKey)
//        // You might also want to store the refresh token separately
//        TokenStorage.shared.save(token: response.refreshToken, for: EvanAuth.tokenKey + "_refresh")
//    }
}

extension EvanAPI {
    func login() async throws {
        guard TokenStorage.shared.load(for: EvanAuth.tokenKey) == nil else { return }
        guard TokenStorage.shared.load(for: EvanAuth.refreshTokenKey) == nil else { return }
        let url = baseURL.appendingPathComponent("users/auth/signin")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Temporary hardcoded credentials
        let body = ["phone": "+37495040077", "password": "Nartekilarde3$"]
        request.httpBody = try JSONEncoder().encode(body)

        let response: APIResponse = try await network.request(request)

        TokenStorage.shared.save(token: response.data.token.accessToken, for: EvanAuth.tokenKey)
        TokenStorage.shared.save(token: response.data.token.refreshToken, for: EvanAuth.refreshTokenKey)
    }
}
