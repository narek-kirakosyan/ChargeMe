//
//  NetworkService.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 17.08.25.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ request: URLRequest) async throws -> T
}

final class DefaultNetworkService: NetworkService {
    private let urlSession: URLSession
    private let interceptor: AuthInterceptor?
    
    init(interceptor: AuthInterceptor? = nil) {
        self.urlSession = URLSession(configuration: .default)
        self.interceptor = interceptor
    }
    
    func request<T: Decodable>(_ request: URLRequest) async throws -> T {
        var finalRequest = request
        
        // Inject token if interceptor exists
        if let interceptor = interceptor {
            finalRequest = try await interceptor.adapt(request: finalRequest)
        }
        
        let (data, response) = try await urlSession.data(for: finalRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // Handle token refresh if 401
        if let interceptor = interceptor,
           try await interceptor.retry(request: finalRequest, response: httpResponse, data: data) {
            return try await self.request(finalRequest)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}




