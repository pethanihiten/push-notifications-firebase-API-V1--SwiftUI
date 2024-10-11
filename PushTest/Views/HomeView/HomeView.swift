//
//  HomeView.swift
//  PushTest
//
//  Created by Vedika on 08/10/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var isButtonDisabled = false
    @State private var firebaseProjects: [FirebaseCredentials] = []
    @State private var selectedProject: FirebaseCredentials? = nil
    @State private var selectedTopic: String = "common_pp"
    @State private var selectedTopicName: String = ""
    @State private var showAlert = false
    @State private var showSound = true
    @State private var showExtraData = true
    @State private var alertMessage = ""
    @State private var notiTitle = ""
    @State private var notiBody = ""
    @State var extraModelArray: [ExtraModel] = [
        ExtraModel(keyName: "", keyVal: "")
    ]
//    @State var selectedLastSendPushModel: LastSendPushModel?
    @State var lastPushArray = [LastSendPushModel]()

    let helper = FirebasePushNotificationHelper()
    let pickerOptions = ["common_pp", "All", "Premium", "user_deal365_1_1"]

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack{

                    HStack {
                        Text("Select Project:")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                        Picker("Select Project", selection: $selectedProject) {
                            ForEach(firebaseProjects, id: \.projectId) { project in
                                Text(project.projectId)
                                    .tag(project as FirebaseCredentials?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    HStack {
                        Text("Select Topic:")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()

                        Picker("Select Topic", selection: $selectedTopic) {
                            ForEach(pickerOptions, id: \.self) { option in
                                Text(option)
                                    .tag(option)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: selectedTopic) { newValue in
                            selectedTopicName = newValue
                        }
                    }

                    HStack {
                        Text("Topic:")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                        TextField("Enter Project Name", text: $selectedTopicName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 15, weight: .medium))
                            .padding(.leading, 15.0)
                        //                            .keyboardType(.next)
                    }

                }.padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    .background(Color.white)
                    .cornerRadius(15)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.05), radius: 5)


                Button(action: {
                    NotificationHelper.notificationTopicRegister(topic: selectedTopicName) { error in
                        if error == nil {
                            alertMessage = "Subscribed to topic \(selectedTopicName)"
                            self.showAlert = true
                        }
                    }
                }) {
                    Text("Topic Register")
                        .font(Fonts.impactRegular(size: 22))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(isButtonDisabled ? Color.gray : Color.red)
                }
                .disabled(isButtonDisabled)
                .opacity(isButtonDisabled ? 0.5 : 1.0)
                .padding()

                //                Divider().padding()

                VStack{
                    HStack {
                        Text("Noti Title:")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                        TextField("Enter Title", text: $notiTitle)
                            .font(.system(size: 15, weight: .medium))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 15.0)
                        //                            .keyboardType(.next)
                    }

                    HStack(alignment: .top) {
                        Text("Noti Body:")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                        TextEditor(text: $notiBody)
                            .font(.system(size: 15, weight: .medium))
                            .frame(height: 130)
                            .cornerRadius(1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 1)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.8)
                            )
                            .padding(.leading, 12.0)
                        //                            .keyboardType(.done)
                            .onTapGesture {
                                hideKeyboard()
                            }
                    }

                    HStack {
                        Toggle("Noti Sound:", isOn: $showSound).font(.system(size: 15, weight: .medium))
                        Toggle("Extra Data:", isOn: $showExtraData).font(.system(size: 15, weight: .medium))
                    }

                    VStack(alignment: .leading) {
                        if showExtraData {
                            HStack {
                                Spacer()
                                NavigationLink(destination: ExtraDataView(extraModelArray: $extraModelArray)) {
                                    Text("Add Column")
                                        .font(Fonts.impactRegular(size: 18))
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                        .frame(width: 110, height: 30)
                                }
                                .background(Color.blue)

                            }.padding(.trailing, -5).padding(.top, 5)
                        }
                    }
                    .frame(maxWidth: .infinity)

                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .background(Color.white)
                    .cornerRadius(15)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.05), radius: 5)

                Button(action: {
                    if notiTitle.isEmpty || notiBody.isEmpty {
                        alertMessage = "Title and Body cannot be empty."
                        showAlert = true
                    } else if let credentials = selectedProject {
                        if let jwt = helper.generateJWT(serviceAccount: credentials) {
                            helper.fetchOAuthToken(jwt: jwt) { token in
                                if let token = token {
                                    print("OAuth 2.0 Token: \(token)")
                                    let topic = selectedTopicName
                                    let title = notiTitle
                                    let body = notiBody
                                    
                                    print(credentials)

                                    //                                    var extraData: [String: Any] = [
                                    //                                        "userId": "12345",
                                    //                                        "screen": "Home",
                                    //                                        "promoCode": "DISCOUNT2024"
                                    //                                    ]

                                    let modelPush = LastSendPushModel(
                                        firebaseCredentials: credentials,
                                        selectedTopicName: selectedTopicName,
                                        showAlert: showAlert,
                                        showSound: showSound,
                                        showExtraData: showExtraData,
                                        notiTitle: notiTitle,
                                        notiBody: notiBody,
                                        extraData: extraModelArray
                                    )
                                    lastPushArray.append(modelPush)
                                    UserDefaultsHelper.saveLastPushArray(lastPushArray)

                                    var extraData = [String: Any]()
                                    for model in extraModelArray {
                                        extraData[model.keyName] = model.keyVal
                                        print(model.dictionary)
                                    }

                                    if !showExtraData{
                                        extraData.removeAll()
                                    }

                                    self.helper.sendPushNotification(projectId: credentials.projectId, toTopic: topic, title: title, body: body, serverToken: token, soundOn: showSound, extraData: extraData)
                                }
                            }
                        }
                    }
                }) {
                    Text("Send Push")
                        .font(Fonts.impactRegular(size: 22))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.green)
                }
                .padding()
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        AssetColor.firstGradientColor.color,
                        AssetColor.secondGradientColor.color
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            //            .background(Color(UIColor.systemGroupedBackground))
            .alert(isPresented: $showAlert) {
                return AlertHelper.createAlert(
                    title: "Topic",
                    message: alertMessage,
                    primaryButtonTitle: "OK",
                    primaryAction: {
                        showAlert = false
                    }
                )
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(Fonts.impactRegular(size: 22))
                        .foregroundColor(.black)
                }
            }
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: PustHistoryView(extraModelArray: $lastPushArray, onSelectModel: { selectedModel in
//                        selectedLastSendPushModel = selectedModel
                        selectedProject = selectedModel.firebaseCredentials
                        selectedTopicName = selectedModel.selectedTopicName
                        notiTitle = selectedModel.notiTitle
                        notiBody = selectedModel.notiBody
                        showSound = selectedModel.showSound
                        showExtraData = selectedModel.showExtraData
                        extraModelArray = selectedModel.extraData

                    })) {
                        Image(systemName: "clock.arrow.circlepath")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                    }
            )
            .onAppear {
                lastPushArray = UserDefaultsHelper.loadLastPushArray()
                if selectedProject == nil{
                    readFileWithName()
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }

    func readFileWithName() {
        let helper = FirebasePushNotificationHelper()
        let files = FileHelper.shared.listDocumentDirectory()
        let jsonFiles = files.filter { $0.pathExtension == "json" }
        firebaseProjects.removeAll()
        for fileURL in jsonFiles {
            if let data = helper.loadServiceAccount(fileURL: fileURL) {
                firebaseProjects.append(data)
            }
        }
        if firebaseProjects.count > 0 {
            if selectedProject == nil{
                selectedProject = firebaseProjects.first
                selectedTopicName = selectedTopic
            }
        }
    }
}

#Preview {
    HomeView()
}



// MARK: - Keyboard Dismiss Function
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
