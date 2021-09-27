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
    @State var flag = false

    var body: some View {
        Alignment {
            Button("Show popup") {
                popupCenter?.popup = Popup(content: {
                    VStack(spacing: 0) {
                        Color.gray
                            .frame(height: 176)
                            .cornerRadius(8)
                            .padding([.top, .horizontal], 32)
                            .padding(.bottom, 16)
                        VStack(spacing: 8) {
                            Text("Title")
                                .preferredFont(for: .body, weight: .bold)
                                .foregroundColor(.dds.primaryText)
                            Text("xxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                                .preferredFont(for: .footnote, weight: .regular)
                                .foregroundColor(.dds.primaryText)
                            Spacer(minLength: 0)
                            CheckButton(title: "Don’t show this alert again", isSelected: $flag)
                                .foregroundColor(.dds.secondaryText)
                            Spacer(minLength: 0)
                        }
                        .padding(.bottom, 12)
                        Button(
                            action: { popupCenter?.popup = nil },
                            label: {
                                HStack {
                                    Spacer()
                                    Text("OK")
                                        .preferredFont(for: .callout, weight: .bold)
                                        .foregroundColor(.dds.primaryText)
                                    Spacer()
                                }
                            }
                        )
                            .padding(.bottom, 24)
                    }
                    .frame(width: 310, height: 377)
                    .background(Color.dds.popupBackground)
                    .cornerRadius(29)
                    .popupTransition()
                })
            }
        }
        .background(Color.dds.primaryBackground)
        .ignoresSafeArea()
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
