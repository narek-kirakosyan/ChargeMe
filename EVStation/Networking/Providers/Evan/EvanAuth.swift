//
//  EvanAuth.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 17.08.25.
//

// EvanAuth.swift

import Foundation

final class EvanAuth {
    static let tokenKey = "evan_token"
    static let refreshTokenKey = "evan_refresh"
    
    private let network = DefaultNetworkService()
    
    func getValidToken() async throws -> AuthToken {
        guard let tokenString = TokenStorage.shared.load(for: EvanAuth.tokenKey) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let token = try AuthToken(jwt: tokenString)
        
        if token.isExpired {
            let refreshedTokenString = try await refreshToken()
            return try AuthToken(jwt: refreshedTokenString)
        } else {
            return token
        }
    }
    
    func login() async throws {
        var request = URLRequest(url: URL(string: "https://evan.am/api/auth/login")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Temporary hardcoded credentials
        let body = ["username": "demo", "password": "demo"]
        request.httpBody = try JSONEncoder().encode(body)
        
        let response: EvanLoginResponse = try await network.request(request)
        
        TokenStorage.shared.save(token: response.accessToken, for: EvanAuth.tokenKey)
        TokenStorage.shared.save(token: response.refreshToken, for: EvanAuth.refreshTokenKey)

        // ✅ Wrap with AuthToken for expiry check
        let token = try AuthToken(jwt: response.accessToken)
        print("Evan login success, token expires at: \(token.expiry)")
    }
    
    func refreshToken() async throws -> String {
        guard let refreshToken = TokenStorage.shared.load(for: EvanAuth.refreshTokenKey) else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request = URLRequest(url: URL(string: "https://evan.am/api/auth/refresh")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["refreshToken": refreshToken]
        request.httpBody = try JSONEncoder().encode(body)
        
        let response: EvanAuthResponse = try await network.request(request)
        let tokenData = response.data.token
        
        TokenStorage.shared.save(token: tokenData.accessToken, for: EvanAuth.tokenKey)
        TokenStorage.shared.save(token: tokenData.refreshToken, for: EvanAuth.refreshTokenKey)
        
        // ✅ Wrap with AuthToken for expiry check
        let token = try AuthToken(jwt: tokenData.accessToken)
        print("Evan refresh success, token expires at: \(token.expiry)")
        
        return token.value
    }
}
