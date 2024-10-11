//
//  PushTestApp.swift
//  PushTest
//
//  Created by Vedika on 08/10/24.
//

import SwiftUI
import Firebase
import IQKeyboardManagerSwift

@main
struct PushTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    IQKeyboardManager.shared.enable = true
    FirebaseApp.configure()
    NotificationHelper.initializeNotification()
    return true
  }
}
