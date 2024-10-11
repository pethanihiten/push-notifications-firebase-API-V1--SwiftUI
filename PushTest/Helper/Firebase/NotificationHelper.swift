//
//  NotificationHelper.swift
//  PHPServer
//
//  Created by Vedika on 08/10/24.
//

import Foundation
import UIKit
import Firebase
import UserNotifications


class NotificationHelper: NSObject, ObservableObject {
    @Published var navigateTo: String?
    
    var commonTopic = "common_pp"

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
    }

    class func initializeNotification() {
        requestNotificationPermissions()
    }

    class func requestNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else if let error = error {
                print("Failed to request authorization: \(error)")
            }
        }
    }

    class func getNotificationSettings() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
//                print("Notification settings: \(settings)")
            }
        } else {
            print("Fallback on earlier versions")
        }
    }

    class func notificationTopicRegister(topic: String, completion: @escaping (Error?) -> Void) {
        Messaging.messaging().subscribe(toTopic: topic) { error in
            if let error = error {
                completion(error)
                print("Failed to subscribe to topic \(topic): \(error)")
            } else {
                completion(nil)
                print("Subscribed to topic \(topic)") //user_deal365_394
            }
        }
    }

    class func notificationTopicRemove(topic: String) {
        Messaging.messaging().unsubscribe(fromTopic: topic) { error in
            if let error = error {
                print("Failed to unsubscribe from topic \(topic): \(error)")
            } else {
                print("Unsubscribed from topic \(topic)")
            }
        }
    }

    class func notificationTap(notification: UNNotificationContent) {
        let userInfo = notification.userInfo
        print("userInfo: \(userInfo)")
        if let aps = userInfo["aps"] as? [String: Any],
           let alert = aps["alert"] as? [String: Any],
           let body = alert["body"] as? String {
            DispatchQueue.main.async {
                NotificationHelper.shared.navigateTo = body // Use body as the destination screen
            }
        } else {
            print("No body found in aps->alert->body")
        }
    }

    static let shared = NotificationHelper()
}

extension NotificationHelper: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
               completionHandler([.banner, .sound, .badge])
           } else {
               completionHandler([.alert, .sound, .badge])
           }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        let content = notification.request.content
        NotificationHelper.notificationTap(notification: content)
        completionHandler()
    }
}

extension NotificationHelper: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate:UNUserNotificationCenterDelegate{

    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        NotificationHelper.postDeviceToken(deviceToken: deviceToken)
        NotificationHelper.notificationTopicRegister(topic: NotificationHelper.shared.commonTopic) { error in
            if let error = error {
                print("Failed to subscribe to topic: \(error.localizedDescription)")
            }
        }
    }

    func application(_ application: UIApplication,didFailToRegisterForRemoteNotificationsWithError error: Error) {
        let deviceTokenString = UIDevice.current.identifierForVendor!.uuidString
        print("Remote notification support is unavailable due to error: \(error.localizedDescription) \(deviceTokenString)")
    }

    func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }

        print(aps)
        print(userInfo)
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}


// MARK: - API Call
extension NotificationHelper{
    class func postDeviceToken(deviceToken: Data) {
//        let token = deviceToken.hexString
//
//        Messaging.messaging().apnsToken = deviceToken
//
//        if(HPUserInfo.getLogin()){
//            print("New Token : \(token)")
//            print("Old Token : \(HPUserInfo.getDeviceToken())")
//
//            if(token != HPUserInfo.getDeviceToken()){
//                apiCallDeviceToken(token: token)
//            }
//        }
//        HPUserInfo.setDeviceToken(str: token)

        func apiCallDeviceToken(token:String) {
    //        DispatchQueue.main.async {
    //            AppUtilites.shared.params = ["business_id":"\(AppUserData.shared.getCoachId())","device_token":token,"device_type":1]
    //            APIClient.adddeviceTokenUpdate(param: AppUtilites.shared.params) { result in
    //                APIClient.dismissProgress()
    //                switch result {
    //                case .success(let data):
    //                        print(data)
    //                case .failure(let error):
    //                    print(error.localizedDescription)
    //                }
    //            }
    //        }
        }
    }
}


