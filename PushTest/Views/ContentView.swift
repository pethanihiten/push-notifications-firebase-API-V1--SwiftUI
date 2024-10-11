//
//  ContentView.swift
//  PushTest
//
//  Created by Vedika on 08/10/24.
//

import SwiftUI
import UserNotifications


struct ContentView: View {
    @State private var notificationHelper = NotificationHelper.shared
    @State private var navigationTitle = "Home"
    @State private var selectedTab = 0

    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(0)
            ImportView()
                .tabItem {
                    Label("Import", systemImage: "arrow.right.circle")
                }.tag(1)
        }
        .accentColor(.black)
        .background(Color.white)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(Color.white) // Background color of the Tab Bar
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray // Color of unselected items
            UITabBar.appearance().tintColor = UIColor.black // Color of selected item
        }
        .onReceive(notificationHelper.$navigateTo) { screen in
            if let screen = screen {
                navigateToScreen(screen)
                notificationHelper.navigateTo = nil
            }
        }

//        NavigationView {
//            TabView(selection: $selectedTab) {
//                HomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "house.fill")
//                    }
//                    .tag(0)
//                ImportView()
//                    .tabItem {
//                        Label("Import", systemImage: "arrow.right.circle")
//                    }
//                    .tag(1)
//            }
//            .onChange(of: selectedTab) { newValue in
//                switch newValue {
//                case 0:
//                    navigationTitle = "Home"
//                case 1:
//                    navigationTitle = "Import"
//                default:
//                    break
//                }
//            }
//            .accentColor(.black)
//            .navigationTitle("AA")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text(navigationTitle)
//                        .font(Fonts.impactRegular(size: 20))
//                        .foregroundColor(.black)
//                        .frame(maxWidth: .infinity)
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .onReceive(notificationHelper.$navigateTo) { screen in
//                if let screen = screen {
//                    navigateToScreen(screen)
//                    notificationHelper.navigateTo = nil
//                }
//            }
//        }
    }

    private func navigateToScreen(_ screen: String) {
        print("Tap Notification \(screen)")
        if screen == "D365AlertsFullVC" {
            // Present the D365AlertsFullVC
            // Example: Use a NavigationLink or another method to navigate
        }
    }
}

#Preview {
    ContentView()
}
