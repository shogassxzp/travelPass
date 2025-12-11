import SwiftUI

struct CarrierCell: View {
    let segment: Segment

    // MARK: - Body

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    if let logo = segment.thread.carrier?.logo, !logo.isEmpty {
                        AsyncImage(url: URL(string: logo)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                        }
                        .frame(width: 40, height: 40)
                        .cornerRadius(8)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                    }

                    Text(segment.thread.carrier?.title ?? "NO_NAME")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.yUniversalBlack)

                    Spacer()

                    // Дата
                    Text(formatDate(segment.departure))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.yUniversalBlack)
                }

                HStack(spacing: 8) {
                    Text(formatTime(segment.departure))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.yUniversalBlack)

                    Rectangle()
                        .fill(Color.yGray)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    Text(segment.durationString)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.yUniversalBlack)

                    Rectangle()
                        .fill(Color.yGray)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)

                    Text(formatTime(segment.arrival))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.yUniversalBlack)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }

    // MARK: - Private Methods

    private func formatTime(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "ru_RU")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        outputFormatter.locale = Locale(identifier: "ru_RU")

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }

        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }

        return "--:--"
    }

    private func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "ru_RU")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }

        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }

        return ""
    }
}
