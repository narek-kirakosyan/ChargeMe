//
//  EvanModels.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 17.08.25.
//

import Foundation

// MARK: - Login / Refresh
struct EvanLoginRequest: Encodable {
    let username: String
    let password: String
}

struct EvanLoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct EvanAuthResponse: Codable {
    let data: EvanAuthData
}

struct EvanAuthData: Codable {
    let token: EvanAuthTokenData
    let user: EvanAuthUser
}

struct EvanAuthTokenData: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: String   // ISO8601 or timestamp depending on API
}

struct EvanAuthUser: Codable {
    let id: String
    let username: String
    let email: String
}

// MARK: - Stations
struct StationListResponse: Codable {
    let data: StationData
    let metadata: Metadata
    let status: Status
}

struct StationData: Codable {
    let stations: [EvanStation]
}

struct Metadata: Codable {
//    let pagination: Pagination
}

struct Pagination: Codable {
    let limit: Int
    let offset: Int
    let total: Int
}

struct Status: Codable {
    let code: Int
    let message: String
}

struct StationsResponse: Codable {
    let data: StationsData
    let metadata: Metadata
    let status: Status
}

struct StationsData: Codable {
    let stations: [EvanStation]
}


struct EvanStation: Codable {
    let id: String
    let name: String
    let uniqueName: String?
    let isEnabled: Bool
    let status: String
    let latitude: Double
    let longitude: Double
    let lastHeartbeat: String?
    let countryCode: String
    let currency: String
    let canStartWhenAvailable: Bool
    let pricingParkingId: String?
    let pricingPowerId: String?
    let pricingReservationId: String?
    let stationAddressId: String
    let stationModelId: String
    let supportPersonId: String?

    let plugs: [EvanPlug]
    let stationAddress: StationAddress
    let stationModel: StationModel
}

struct EvanPlug: Codable {
    let id: String
    let stationId: String
    let stationModelId: String
    let connectorId: Int
    let isEnabled: Bool
    let status: String
    let currentError: String
    let lastError: String?
    let activeChargePercent: Double?
    
    let adapters: [PlugAdapter]
    let plugType: EvanPlugType
    let plugTypeId: String
    let plugTypeVariant: PlugTypeVariant
    let plugTypeVariantId: String
}

struct EvanPlugType: Codable {
    let id: String
    let type: String
    let typeHint: String?
    let powerType: String
    let iconAvailable: String
    let iconBusy: String
    let iconFaulted: String
    let iconInactive: String
    let iconParking: String
}

struct PlugTypeVariant: Codable {
    let id: String
    let name: String
    let plugTypeId: String
    let amperage: Double
    let power: Double
    let voltage: Int
}

struct PlugAdapter: Codable {
    let id: String
    let plugId: String
    let plugAdapterModel: PlugAdapterModel
    let plugAdapterModelId: String
}

struct PlugAdapterModel: Codable {
    let id: String
    let createdAt: String?
    let updatedAt: String?
    let inputPlugTypeId: String
    let outputPlugTypeId: String
    let inputPlugType: EvanPlugType
    let outputPlugType: EvanPlugType
}

struct StationModel: Codable {
    let id: String
    let name: String
    let type: String
}

struct StationAddress: Codable {
    let id: String
    let address: String
    let city: String
    let country: String
    let countryCode: String
    let latitude: Double
    let longitude: Double
    let restricted: Bool
}


struct APIResponse: Codable {
    let data: ResponseData
    let metadata: Metadata
    let status: Status
}

struct ResponseData: Codable {
    let status: String
    let token: Token
    let user: User
}

struct Token: Codable {
    let accessToken: String
    let expiresAfter: Int
    let expiresAt: Int64
    let refreshToken: String
}

struct User: Codable {
    let avatar: String
    let countryCode: String?
    let email: String
    let firstName: String
    let id: String
    let isCompanyOwner: Bool
    let isPartner: Bool
    let lastName: String
    let phone: String
    let role: String
    let status: String
}
