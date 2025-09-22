//
//  AuthToken.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 25.08.25.
//

import Foundation

enum AuthTokenError: Error {
    case invalidToken
}

struct AuthToken {
    let value: String
    let expiry: Date

    var isExpired: Bool {
        return Date() >= expiry
    }

    init(jwt: String) throws {
        self.value = jwt
        self.expiry = try AuthToken.decodeJWTExpiry(jwt)
    }

    static func decodeJWTExpiry(_ jwt: String) throws -> Date {
        let segments = jwt.components(separatedBy: ".")
        guard segments.count >= 2 else {
            throw AuthTokenError.invalidToken
        }

        let payloadSegment = segments[1]

        var base64 = payloadSegment
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let paddedLength = 4 - base64.count % 4
        if paddedLength < 4 {
            base64 += String(repeating: "=", count: paddedLength)
        }

        guard let payloadData = Data(base64Encoded: base64),
              let json = try? JSONSerialization.jsonObject(with: payloadData),
              let dict = json as? [String: Any],
              let exp = dict["exp"] as? TimeInterval else {
            throw AuthTokenError.invalidToken
        }

        return Date(timeIntervalSince1970: exp)
    }
}
