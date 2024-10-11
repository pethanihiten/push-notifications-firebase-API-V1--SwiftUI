import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct ImportView: View {
    @State private var importing = false
    @State private var showAlert = false
    @State private var alertType: AlertType?
    @State private var alertMessage = ""
    @State private var showConfirmationAlert = false
    @State private var firebaseProjectsURL: [URL] = []
    @State private var firebaseProjects: [FirebaseCredentials] = []
    @State private var projectToDelete: String? = nil

    enum AlertType {
        case importStatus
        case confirmDeletion
    }

    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        AssetColor.firstGradientColor.color,
                        AssetColor.secondGradientColor.color
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()


//                    ScrollView {
//                        ForEach($firebaseProjects, id: \.projectId) { project in
//                            ContactDetails(
//                                project: project,
//                                projectToDelete: $projectToDelete,
//                                showAlert: $showAlert,
//                                alertType: $alertType
//                            )
//                        }.padding()
//                        .onAppear {
//                            readFileWithName()
//                        }
//                    }

                List {
                    ForEach($firebaseProjects, id: \.projectId) { project in
                        VStack {
                            ContactDetails1(
                                project: project,
                                projectToDelete: $projectToDelete,
                                showAlert: $showAlert,
                                alertType: $alertType
                            )
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: -1, leading: -1, bottom: -1, trailing: -1))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(Color(UIColor.clear))
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    readFileWithName()
                }
                .listRowBackground(Color.green)
                .padding(.top, 20)
                .padding(.horizontal)
                .background(Color(UIColor.clear))
            }
            .navigationTitle("Project List")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Project List")
                        .font(Fonts.impactRegular(size: 22))
                        .foregroundColor(.black)
                }
            }
            .fileImporter(isPresented: $importing, allowedContentTypes: [.json]) { result in
                switch result {
                case .success(let file):
                    if file.startAccessingSecurityScopedResource() {
                        defer { file.stopAccessingSecurityScopedResource() }
                        FileHelper.shared.importJsonFile(from: file) { message in
                            alertMessage = message
                            alertType = .importStatus
                            showAlert = true
                        }
                        readFileWithName()
                    } else {
                        alertMessage = "Failed to access the selected file"
                        alertType = .importStatus
                        showAlert = true
                    }
                case .failure(let error):
                    alertMessage = "Failed to import file: \(error.localizedDescription)"
                    alertType = .importStatus
                    showAlert = true
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                importing = true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
            )
            .alert(isPresented: $showAlert) {
                switch alertType {
                case .importStatus:
                    return AlertHelper.createAlert(
                        title: "File Status",
                        message: alertMessage,
                        primaryButtonTitle: "OK",
                        primaryAction: {
                            showAlert = false  // Reset to allow future alerts
                        }
                    )
                case .confirmDeletion:
                    return AlertHelper.createAlert(
                        title: "Confirm Deletion",
                        message: "Are you sure you want to delete this project?",
                        primaryButtonTitle: "Delete",
                        primaryAction: {
                            if let project = projectToDelete {
                                deleteFile(at: project)
                            }
                            showAlert = false  // Reset after the action
                        },
                        secondaryButtonTitle: "Cancel",
                        secondaryAction: {
                            showAlert = false  // Reset after cancel
                        }
                    )
                case .none:
                    return AlertHelper.createAlert(
                        title: "Error",
                        message: "An unknown error occurred.",
                        primaryButtonTitle: "OK",
                        primaryAction: {
                            showAlert = false  // Reset after the error alert
                        }
                    )
                }
            }
        }
    }

    func readFileWithName() {
        let helper = FirebasePushNotificationHelper()
        let files = FileHelper.shared.listDocumentDirectory()
        if files.count > 0{
            let jsonFiles = files.filter { $0.pathExtension == "json" }
            firebaseProjects.removeAll()
            firebaseProjectsURL.removeAll()
            for fileURL in jsonFiles {
                if let data = helper.loadServiceAccount(fileURL: fileURL) {
                    firebaseProjectsURL.append(fileURL)
                    firebaseProjects.append(data)
                }
            }
        }
    }

    func deleteFile(at projectId: String) {
        let helper = FirebasePushNotificationHelper()
        var fileDeleted = false

        for (_, fileURL) in firebaseProjectsURL.enumerated() {
            if let data = helper.loadServiceAccount(fileURL: fileURL), data.projectId == projectId {
                FileHelper.shared.deleteFile(at: fileURL) { msg in
                    alertMessage = msg
                    fileDeleted = true
                }
                break
            }
        }

        if !fileDeleted {
            alertMessage = "No project found with ID: \(projectId)"
        }

        DispatchQueue.main.async {
            alertType = .importStatus
            showAlert = true
            readFileWithName()
        }
    }
}

#Preview {
    ImportView()
}
