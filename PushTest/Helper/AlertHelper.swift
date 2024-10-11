//
//  AlertHelper.swift
//  PushTest
//
//  Created by Vedika on 09/10/24.
//

import Foundation
import SwiftUI

class AlertHelper {

    static func createAlert(title: String, message: String, primaryButtonTitle: String = "OK", primaryAction: @escaping () -> Void = {}, secondaryButtonTitle: String? = nil, secondaryAction: (() -> Void)? = nil) -> Alert {

        if let secondaryButtonTitle = secondaryButtonTitle, let secondaryAction = secondaryAction {
            // Alert with two buttons
            return Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .destructive(Text(primaryButtonTitle), action: primaryAction),
                secondaryButton: .cancel(Text(secondaryButtonTitle), action: secondaryAction)
            )
        } else {
            // Alert with one button
            return Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text(primaryButtonTitle), action: primaryAction)
            )
        }
    }
}
