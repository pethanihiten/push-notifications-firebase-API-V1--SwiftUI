//
//  PushHistoryDataRowView.swift
//  PushTest
//
//  Created by Vedika on 11/10/24.
//

import SwiftUI

struct PushHistoryDataRowView: View {

    @Binding var model: LastSendPushModel
    var onRemove: () -> Void
    var onTapBack: () -> Void

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

            HStack {
                VStack(alignment: .leading) {
                    HStack{
                        Text("Project Name:")
                            .font(.system(size: 14, weight: .bold))
                        Text(model.firebaseCredentials.projectId)
                            .font(.system(size: 14, weight: .medium))
                    }

                    HStack{
                        Text("Topic Name:")
                            .font(.system(size: 14, weight: .bold))
                        Text(model.selectedTopicName)
                            .font(.system(size: 14, weight: .medium))
                    }

                    HStack{
                        Text("Push Title:")
                            .font(.system(size: 14, weight: .bold))
                        Text(model.notiTitle)
                            .font(.system(size: 14, weight: .medium))
                    }

                    HStack{
                        Text("Push Body:")
                            .font(.system(size: 14, weight: .bold))
                        Text(model.notiBody)
                            .font(.system(size: 14, weight: .medium))
                    }

                    HStack{
                        Text("Push Extra:")
                            .font(.system(size: 14, weight: .bold))

                        VStack(alignment: .leading) {
                            ForEach(model.extraData, id: \.id) { extra in
                                Text("Key: \(extra.keyName), Value: \(extra.keyVal)")
                                    .font(.system(size: 13))
                            }
                        }

                    }

                }.frame(maxWidth: .infinity, alignment: .leading)

            }
            .onTapGesture {
                onTapBack()
            }
            .padding(.top, 5)
        }
        .frame(maxWidth: .infinity)
        .padding([.vertical, .horizontal], 15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}
