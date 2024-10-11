import Foundation
import SwiftUI

struct ContactDetails: View {
    @Binding var project: FirebaseCredentials // Use the direct project instead of Binding
    @Binding var projectToDelete: String?
    @Binding var showAlert: Bool
    @Binding var alertType: ImportView.AlertType?

    var body: some View {

        VStack(alignment: .leading) {

            HStack() {
                Text("\(project.projectId)")
                    .padding(.top, 4)
                    .font(.system(size: 18))

                Spacer()

                Button(action: {
                    projectToDelete = project.projectId
                    alertType = .confirmDeletion
                    showAlert = true
                }) {
                    Text("Delete")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 22)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding([.vertical, .horizontal], 15)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.05), radius: 5)

        }

    }
}


struct ContactDetails1: View {
    @Binding var project: FirebaseCredentials // Use the direct project instead of Binding
    @Binding var projectToDelete: String?
    @Binding var showAlert: Bool
    @Binding var alertType: ImportView.AlertType?

    var body: some View {

        VStack(alignment: .leading) {

            HStack() {
                Text("\(project.projectId)")
                    .padding(.top, 4)
                    .font(.system(size: 18))
                Spacer()

                Button(action: {
                    projectToDelete = project.projectId
                    alertType = .confirmDeletion
                    showAlert = true
                }) {
                    Text("Delete")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 22)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.bottom)
    }
}
