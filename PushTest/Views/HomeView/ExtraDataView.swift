//
//  ExtraDataView.swift
//  PushTest
//
//  Created by Vedika on 11/10/24.
//

import Foundation
import SwiftUI

struct ExtraDataView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var extraModelArray: [ExtraModel]

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
                    ExtraDataRowView(model: $model, onRemove: {
                        if let index = extraModelArray.firstIndex(where: { $0.id == model.id }) {
                            extraModelArray.remove(at: index)
                        }
                    })
                }.padding()
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .background(Color(UIColor.clear))

        }
        .navigationTitle("Extra Data")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Extra Data")
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
            },
            trailing: Button(action: {
                extraModelArray.append(ExtraModel(keyName: "", keyVal: ""))
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
        )
    }
}
