import SwiftUI

struct VideoRow: View {
    let video: Video

    var body: some View {
        HStack {
            // Завантаження мініатюри
            AsyncImage(url: URL(string: video.snippet.thumbnails.high.url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 60)
                    .clipped()
            } placeholder: {
                Color.gray.frame(width: 100, height: 60)
            }

            // Інформація про відео
            VStack(alignment: .leading) {
                Text(video.snippet.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(video.snippet.description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
        }
    }
}
