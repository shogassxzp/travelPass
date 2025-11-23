//
//  CityPickerScreen.swift
//  travelPass
//
//  Created by Игнат Рогачевич on 22.11.25.
//

import SwiftUI

struct CityPickerScreen: View {
    @State var searchString: String = ""
    @State var cities = ["Москва", "Санкт-Петербург", "Сочи", "Краснодар"]

    var filteredCities: [String] {
        if searchString.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchString) }
        }
    }

    var body: some View {
        VStack {
            TextField("Введите запрос", text: $searchString)
                .textFieldStyle(.plain)
                .font(.system(size: 17, weight: .regular))
                .padding(.horizontal, 30)
                .frame(height: 36)
                .background(.yLightGray)
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.yGray)
                            .padding(.leading, 8)

                        Spacer()

                        if !searchString.isEmpty {
                            Button(action: clearTextField) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.yGray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 16)
        }

        ScrollView {
            if filteredCities.isEmpty {
                VStack {
                    Spacer()

                    Text("Город не найден")
                        .foregroundStyle(.yBlack)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 40)

                    Spacer()
                }
                .frame(height: UIScreen.main.bounds.height * 0.8)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(filteredCities, id: \.self) { city in
                        HStack {
                            Text(city)
                                .foregroundStyle(.primary)
                                .font(.system(size: 16, weight: .regular))
                                .padding(.leading, 24) // Базовые 16 + 8 оверлей

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundStyle(.yBlack)
                                .font(.system(size: 14))
                                .padding(.trailing, 24) // Базовые 16 + 8 оверлей
                        }

                        .padding(.vertical, 12)
                    }
                }
            }
        }
    }

    private func clearTextField() {
        searchString = ""
    }
}

#Preview {
    CityPickerScreen()
}
