//
//  UserDefaultsHelper.swift
//  PushTest
//
//  Created by Vedika on 11/10/24.
//

import Foundation


class UserDefaultsHelper {

    // Save the last push array to UserDefaults
    static func saveLastPushArray(_ array: [LastSendPushModel]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(array)
            UserDefaults.standard.set(encoded, forKey: "lastPushArray")
        } catch {
            print("Failed to save last push array: \(error.localizedDescription)")
        }
    }

    // Load the last push array from UserDefaults
    static func loadLastPushArray() -> [LastSendPushModel] {
        if let savedData = UserDefaults.standard.data(forKey: "lastPushArray") {
            let decoder = JSONDecoder()
            do {
                let loadedArray = try decoder.decode([LastSendPushModel].self, from: savedData)
                return loadedArray
            } catch {
                print("Failed to load last push array: \(error.localizedDescription)")
            }
        }
        return [] // Return an empty array if loading fails
    }

    // Add a new push model to the last push array
    static func addPushModel(_ model: LastSendPushModel) {
        var lastPushArray = loadLastPushArray()
        lastPushArray.append(model)
        saveLastPushArray(lastPushArray)
    }

    // Remove a push model at the specified index
    static func removePushModel(at index: Int) {
        var lastPushArray = loadLastPushArray()
        if index < lastPushArray.count {
            lastPushArray.remove(at: index)
            saveLastPushArray(lastPushArray)
        } else {
            print("Index out of bounds")
        }
    }
}
