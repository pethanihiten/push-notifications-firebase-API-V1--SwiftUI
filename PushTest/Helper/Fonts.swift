//
//  FontHelper.swift
//  PushTest
//
//  Created by Vedika on 08/10/24.
//

import SwiftUI
import UIKit

class Fonts {
    static let shared = Fonts()

    static let ImpactRegular = "Impact"

    // Fetch all available fonts in the system
    func getAllFonts() -> [String] {
        return UIFont.familyNames.flatMap { familyName in
            UIFont.fontNames(forFamilyName: familyName)
        }
    }

    // Get fonts for a specific family name
    func getFontsForFamily(familyName: String) -> [String] {
        return UIFont.fontNames(forFamilyName: familyName)
    }

    // Check if a font exists
    func isFontAvailable(fontName: String) -> Bool {
        return getAllFonts().contains(fontName)
    }

    // Get a custom SwiftUI font by name
    func customFont(name: String, size: CGFloat) -> Font {
        return Font.custom(name, size: size)
    }

    // Get a custom UIFont for UIKit
    func customUIFont(name: String, size: CGFloat) -> UIFont? {
        return UIFont(name: name, size: size)
    }
}

extension Fonts{
    static func impactRegular(size: CGFloat) -> Font {
        return Font.custom(ImpactRegular, size: size)
    }
}
