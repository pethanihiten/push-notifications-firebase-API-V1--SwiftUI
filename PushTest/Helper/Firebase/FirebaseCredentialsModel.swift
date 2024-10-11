//
//  ServiceAccount.swift
//  PHPServer
//
//  Created by Vedika on 07/10/24.
//

import Foundation
import SwiftJWT


struct MyClaims: Claims {
    let iss: String
    let sub: String
    let aud: String
    let iat: Date
    let exp: Date
    let scope: String
}


struct FirebaseCredentials: Codable,Hashable,Identifiable {
    let type: String
    var projectId: String
    let privateKeyId: String
    let privateKey: String
    let clientEmail: String
    let clientId: String
    let authUri: String
    let tokenUri: String
    let authProviderX509CertUrl: String
    let clientX509CertUrl: String
    let universeDomain: String

    var id: String {
        projectId
    }

    enum CodingKeys: String, CodingKey {
        case type
        case projectId = "project_id"
        case privateKeyId = "private_key_id"
        case privateKey = "private_key"
        case clientEmail = "client_email"
        case clientId = "client_id"
        case authUri = "auth_uri"
        case tokenUri = "token_uri"
        case authProviderX509CertUrl = "auth_provider_x509_cert_url"
        case clientX509CertUrl = "client_x509_cert_url"
        case universeDomain = "universe_domain"
    }
}
