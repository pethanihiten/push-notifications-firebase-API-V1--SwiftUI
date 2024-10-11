//
//  FileHelper.swift
//  PushTest
//
//  Created by Vedika on 08/10/24.
//

import Foundation

class FileHelper {
    static let shared = FileHelper()

    private init() {}

    /// Gets all files in the specified directory.
    func getFiles(in directoryURL: URL) -> [URL] {
        let fileManager = FileManager.default
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            return fileURLs
        } catch {
            print("Error getting files: \(error.localizedDescription)")
            return []
        }
    }

    /// Moves a file from source to destination.
    func moveFile(from sourceURL: URL, to destinationURL: URL) {
        let fileManager = FileManager.default

        do {
            // Check if the file already exists at the destination URL
            if fileManager.fileExists(atPath: destinationURL.path) {
                // Remove the existing file
                try fileManager.removeItem(at: destinationURL)
                print("Existing file removed: \(destinationURL)")
            }

            // Move the new file to the destination URL
            try fileManager.moveItem(at: sourceURL, to: destinationURL)
            print("File moved to: \(destinationURL)")
        } catch {
            print("Failed to move file: \(error.localizedDescription)")
        }
    }

    /// Moves all files from a source directory to a destination directory.
    func moveAllFiles(from sourceDirectory: URL, to destinationDirectory: URL) {
        let fileURLs = getFiles(in: sourceDirectory)
        let fileManager = FileManager.default
        for fileURL in fileURLs {
            let destinationURL = destinationDirectory.appendingPathComponent(fileURL.lastPathComponent)
            moveFile(from: fileURL, to: destinationURL)
        }
    }


    /// Imports a JSON file and moves it to the Documents directory.
    func importJsonFile(from sourceURL: URL, completion: @escaping (String) -> Void) {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion("Could not find documents directory")
            return
        }
        let destinationURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        do {
            // Check if the file already exists at the destination URL
            if fileManager.fileExists(atPath: destinationURL.path) {
                // Remove the existing file
                try fileManager.removeItem(at: destinationURL)
                print("Existing file removed: \(destinationURL)")
            }

            // Move the file to Documents directory
            try fileManager.moveItem(at: sourceURL, to: destinationURL)
            print("File imported successfully to: \(destinationURL)")

            // Call completion with a success message
            completion("File imported successfully: \(destinationURL.lastPathComponent)")
        } catch {
            print("Failed to import file: \(error.localizedDescription)")
            completion("Failed to import file: \(error.localizedDescription)")
        }
    }

    func listDocumentDirectory() -> [URL] {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find documents directory")
            return []
        }
        do {
            let files = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            return files
        } catch {
            print("Error reading directory: \(error.localizedDescription)")
        }
        return []
    }

    func deleteFile(at url: URL, completion: @escaping (String) -> Void) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: url)
            completion("File deleted successfully")
        } catch {
            completion("Failed to import file: \(error.localizedDescription)")
        }
    }

}


