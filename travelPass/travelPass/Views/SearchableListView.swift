import SwiftUI

struct SearchableListView: View {
    let title: String
    let placeholder: String
    let emptyMessage: String
    @Binding var searchString: String
    let items: [String]
    let onItemSelected: (String) -> Void
    @Environment(\.dismiss) private var dismiss

    var filteredItems: [String] {
        if searchString.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchString) }
        }
    }

    var body: some View {
        HStack{
            Button(action: {dismiss()}) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.yBlack)
            }
            .padding(.leading,16)
            Spacer()
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .padding(.trailing, 16)
            Spacer()
        }
        LazyVStack {
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
            if items.isEmpty {
                VStack {
                    Spacer()

                    Text(emptyMessage)
                        .foregroundStyle(.yBlack)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 40)

                    Spacer()
                }
                .frame(height: UIScreen.main.bounds.height * 0.8)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(filteredItems, id: \.self) { item in
                        Button(action: {
                            onItemSelected(item)
                        }) {
                            HStack {
                                Text(item)
                                    .foregroundStyle(.primary)
                                    .font(.system(size: 16, weight: .regular))
                                    .padding(.leading, 24)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.yBlack)
                                    .font(.system(size: 14))
                                    .padding(.trailing, 24)
                            }
                            .padding(.vertical, 12)
                        }
                    }
                }
            }
        }
    }

    private func clearTextField() {
        searchString = ""
    }
}
