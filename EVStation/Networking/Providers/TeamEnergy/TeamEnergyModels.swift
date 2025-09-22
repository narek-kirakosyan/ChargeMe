//
//  TeamEnergyModels.swift
//  EVStation
//
//  Created by Narek Kirakosyan on 25.08.25.
//

import Foundation

// Raw DTOs from TeamEnergy API

struct TeamEnergyStationDTO: Decodable {
    let stationId: String
    let displayName: String
    let latitude: Double
    let longitude: Double
    let available: Bool
}

struct TeamEnergyLoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct AuthResponse: Codable {
    let accessToken: String
    let data: UserData
    let errors: [String]
    let guestMode: Bool
    let messages: [String]
    let succeeded: Bool

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case data, errors, guestMode, messages, succeeded
    }
}

struct UserData: Codable {
    let balance: String?
    let cars: [Car]
    let companyLimit: String?
    let companyLimitType: Int
    let culture: String?
    let email: String
    let idToken: String
    let isActiveKwLimitPromoCode: Int
    let isBalanceAllowed: Bool
    let isOurSubscriber: Bool
    let isPublic: Bool
    let isRegisteredInAmdocs: Bool
    let mainCard: String?
    let mobile: String
    let name: String
    let promoAvailableLimit: Int
    let promoCodeId: String?
    let promoExpireDate: String?
    let promoLimit: Int
    let salePercentage: Int
    let surname: String
    let userId: String
    let userName: String
    let userSN: Int
    let virtualPhoneNumber: String?
}

struct Car: Codable {
    let carModel: String
    let carVendor: String
    let powerCapacity: Int
}


import Foundation

struct TeamEnergyStationResponse: Codable {
    let accessToken: String?
    let data: [TeamEnergyStationData]
    let errors: [String]
    let guestMode: Bool
    let messages: [String]
    let succeeded: Bool

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case data, errors, guestMode, messages, succeeded
    }
}

struct TeamEnergyStationData: Codable {
    let address: String
    let cars: [TeamEnergyCar]
    let chargePointId: String
    let chargePointInfos: [ChargePointInfo]
    let connectors: [Connector]
    let key: String
    let latitude: Double
    let longitude: Double
    let name: String
    let phone: String
    let status: String
}

struct TeamEnergyCar: Codable {
    let carModel: String
    let carVendor: String
    let fullCharge: Int
    let powerCapacity: Int
}

struct ChargePointInfo: Codable {
    let chargePointId: String
    let connectors: [Connector]
    let isSeperated: Bool
    let stationName: String
    let stationNumber: String?
}

struct Connector: Codable {
    let adapterOptions: [AdapterOption]?
    let connectorId: String
    let connectorNumber: Int
    let connectorType: String
    let connectorTypeGroup: String
    let connectorTypeId: Int
    let isPrepairing: Bool
    let key: String
    let power: Int
    let powerTypeId: Int
    let price: Int
    let stateOfBattery: Int
    let status: String
    let statusDescription: String
    let systemChargerTypeId: Int
    let systemConnectorTypeId: Int
}

struct AdapterOption: Codable {
    let completionInfo: String?
    let details: AdapterDetails?
    let icon: String
    let identifier: String
    let info: String
    let name: String
    let systemAdapterOptionId: Int
}

struct AdapterDetails: Codable {
    let bannerUrl: String
    let content: String
    let videoUrl: String
}
