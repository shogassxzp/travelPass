//
//  MainScreen.swift
//  travelPass
//
//  Created by Игнат Рогачевич on 22.11.25.
//

import SwiftUI

struct MainScreen: View {
    @State var from = "from"
    @State var to = "to"
    @State var showingCityPicker = false
    @State var selectedField: FieldType

    enum FieldType {
        case from, to
    }

    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    Text("From")
                        .foregroundStyle(.yGray)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("To")
                        .foregroundStyle(.yGray)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(.white)
                .cornerRadius(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                

                Button(action: {}) {
                    Image(systemName: "arrow.2.squarepath")
                        .frame(width: 36, height: 36)
                        .background(.yUniversalWhite)
                        .cornerRadius(40)
                        .padding(.trailing, 16)
                }
            }
            .background(.yBlue)
            .cornerRadius(20)
            .padding(32)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MainScreen()
}
