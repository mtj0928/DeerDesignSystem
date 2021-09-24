//
//  ContentView.swift
//  Shared
//
//  Created by Junnosuke Matsumoto on 2021/08/13.
//

import SwiftUI
import DDS

struct TextAndButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.dds.primaryBackground)
                .ignoresSafeArea()
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: 11.0) {
                        Text("Primary Text Color: Deer / まつじ / 松本")
                            .dds
                            .body
                        Text("Secondary Text Color: Deer / まつじ / 松本")
                            .foregroundColor(Color.dds.secondaryText)
                            .dds
                            .body
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(Color.dds.secondaryBackground)
                                .frame(height: 76)
                            HStack {
                                VStack(alignment: .leading, spacing: 11) {
                                    Text("Secondary Background (primary)")
                                        .dds
                                        .body
                                    Text("Secondary Background (secondary)")
                                        .foregroundColor(Color.dds.secondaryText)
                                        .dds
                                        .body

                                }
                                Spacer()
                            }
                            .padding(14)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(16.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextAndButtonView()
            .colorScheme(.light)
        TextAndButtonView()
            .colorScheme(.dark)
    }
}
