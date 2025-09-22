//
//  AuthInterceptor.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 17.08.25.
//

import Foundation

protocol AuthInterceptor {
    /// Adds authentication headers before sending request
    func adapt(request: URLRequest) async throws -> URLRequest
    
    /// Handles retry logic on authentication errors (e.g., token expired)
    func retry(request: URLRequest,
               response: HTTPURLResponse,
               data: Data) async throws -> Bool
}

final class DefaultAuthInterceptor: AuthInterceptor {
    private let tokenStorage: TokenStorage
    private let tokenKey: String
    private let refreshHandler: () async throws -> String
    
    init(tokenStorage: TokenStorage = .shared,
         tokenKey: String,
         refreshHandler: @escaping () async throws -> String) {
        self.tokenStorage = tokenStorage
        self.tokenKey = tokenKey
        self.refreshHandler = refreshHandler
    }
    
    func adapt(request: URLRequest) async throws -> URLRequest {
        var request = request
        if let token = tokenStorage.load(for: tokenKey) {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    func retry(request: URLRequest,
               response: HTTPURLResponse,
               data: Data) async throws -> Bool {
        if response.statusCode == 401 {
            // refresh the token
            let newToken = try await refreshHandler()
            tokenStorage.save(token: newToken, for: tokenKey)
            return true
        }
        return false
    }
}
