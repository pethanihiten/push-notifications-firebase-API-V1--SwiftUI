//
//  ExtraDataRowView.swift
//  PushTest
//
//  Created by Vedika on 11/10/24.
//

import SwiftUI

struct ExtraDataRowView: View {

    @Binding var model: ExtraModel
    var onRemove: () -> Void

    var body: some View {

        VStack(alignment: .trailing){
            Button(action: {
                onRemove()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.red)
            }
            .buttonStyle(PlainButtonStyle())

            HStack(alignment: .center) {
                Text("Key:")
                    .font(.system(size: 15))
                    .frame(minWidth: 40)

                TextField("Enter Key Name", text: $model.keyName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size: 15, weight: .medium))
                    .padding(.leading, 15.0)
            }.padding(.top, 10)

            HStack(alignment: .center) {
                Text("Value:")
                    .font(.system(size: 15))
                    .frame(minWidth: 40)

                TextField("Enter Key Value", text: $model.keyVal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size: 15, weight: .medium))
                    .padding(.leading, 15.0)
            }
        }
        .padding([.vertical, .horizontal], 15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.05), radius: 5)

    }
}
