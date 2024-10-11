//
//  PustHistoryView.swift
//  PushTest
//
//  Created by Vedika on 11/10/24.
//


import SwiftUI

struct PustHistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var extraModelArray: [LastSendPushModel]
    var onSelectModel: (LastSendPushModel) -> Void
    

    var body: some View {
        ZStack {

            LinearGradient(
                gradient: Gradient(colors: [
                    AssetColor.firstGradientColor.color,
                    AssetColor.secondGradientColor.color
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                ForEach($extraModelArray) { $model in
                    PushHistoryDataRowView(model: $model, onRemove: {
                        if let index = extraModelArray.firstIndex(where: { $0.id == model.id }) {
                            extraModelArray.remove(at: index)
                            UserDefaultsHelper.removePushModel(at: index)
                        }
                    }, onTapBack: {
                        if let index = extraModelArray.firstIndex(where: { $0.id == model.id }) {
                            let model = extraModelArray[index]
                            onSelectModel(model)
                        }
                        presentationMode.wrappedValue.dismiss()
                    })
                }.padding()
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .background(Color(UIColor.clear))

        }
        .navigationTitle("Push History")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Push History")
                    .font(Fonts.impactRegular(size: 22))
                    .foregroundColor(.black)
            }
        }
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
        )
    }
}
