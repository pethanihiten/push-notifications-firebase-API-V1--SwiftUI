import SwiftUI

struct ContentView1: View {
    var body: some View {
        TabView {
            AirplaneView()
                .tabItem {
                    Label("Airplane Tab", systemImage: "airplane.circle")
                }
            PlanetView()
                .tabItem {
                    Label("Planet Tab", systemImage: "globe.americas.fill")
                }
        }
    }
}

struct AirplaneView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Airplane tab view")
                Divider()
                NavigationLink(destination: NestedItemA()) {
                    Text("Go to nested airplane view")
                }
            }
            .navigationTitle("Airplane")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PlanetView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Planet tab view")
                Divider()
                NavigationLink(destination: NestedItemB()) {
                    Text("Go to nested planet view")
                }
            }
            .navigationTitle("Planet")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                trailing: Button(action: {
                    // Action for right button
                    print("Right button tapped")
                }) {
                    Text("Right")
                }
            )
        }
    }
}

struct NestedItemA: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Airplane goes vroom")
        }
        .navigationTitle("Nested airplane")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationBarItems(
            leading: Button(action: {
                // Custom back action
                print("Left button tapped")
                presentationMode.wrappedValue.dismiss() // Dismiss the view
            }) {
                Text("Back") // Custom back button label
            },
            trailing: Button(action: {
                // Action for right button
                print("Right button tapped")
            }) {
                Text("Right")
            }
        )
    }
}

struct NestedItemB: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Planet spin good")
        }
        .navigationTitle("Nested planet")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationBarItems(
            leading: Button(action: {
                // Custom back action
                print("Left button tapped")
                presentationMode.wrappedValue.dismiss() // Dismiss the view
            }) {
                Text("Back") // Custom back button label
            },
            trailing: Button(action: {
                // Action for right button
                print("Right button tapped")
            }) {
                Text("Right")
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
