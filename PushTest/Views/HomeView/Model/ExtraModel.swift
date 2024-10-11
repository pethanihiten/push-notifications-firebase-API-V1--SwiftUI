//
//  ExtraModel.swift
//  PushTest
//
//  Created by Vedika on 11/10/24.
//

import SwiftUI

struct ExtraModel: Identifiable, Codable {
    var id = UUID()
    var keyName: String
    var keyVal: String
    
    var dictionary: [String: Any] {
        return [
            "keyName": keyName,
            "keyVal": keyVal
        ]
    }
}


struct LastSendPushModel: Identifiable, Codable {
    var id = UUID()
    var firebaseCredentials: FirebaseCredentials
    var selectedTopicName: String
    var showAlert: Bool
    var showSound: Bool
    var showExtraData: Bool
    var notiTitle: String
    var notiBody: String
    var extraData: [ExtraModel]
}
