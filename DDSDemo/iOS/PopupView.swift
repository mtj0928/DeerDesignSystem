//
//  PopupView.swift
//  DDSDemo (iOS)
//
//  Created by Junnosuke Matsumoto on 2021/09/26.
//

import SwiftUI
import DeerDesignSystem

struct PopupView: View {

    @Environment(\.popupCenter) var popupCenter

    var body: some View {
        Button("Show popup") {
            popupCenter?.popup = Popup(content: {
                VStack {
                    Text("Popup")
                    Spacer()
                    Button("OK") {
                        popupCenter?.popup = nil
                    }
                }
                .padding()
                .frame(width: 200, height: 200)
                .background(Color.dds.primaryBackground)
                .cornerRadius(12)
//                .transition(.scale.animation(.linear.speed(2)))
            })
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
