import SwiftUI

struct PopularVideosView: View {
    @State private var videos: [Video] = []
    let youtubeService = YouTubeService()

    var body: some View {
        NavigationView {
            List(videos) { video in
                NavigationLink(destination: VideoWebView(videoId: video.id)) {
                    HStack {
                        if let thumbnailURL = URL(string: video.snippet.thumbnails.high.url) {
                            AsyncImage(url: thumbnailURL) { image in
                                image.resizable().scaledToFit().frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                        }

                        VStack(alignment: .leading) {
                            Text(video.snippet.title)
                                .font(.headline)
                                .lineLimit(2)

                            Text("\(video.statistics.viewCount) views")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text(video.snippet.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle("Popular Videos")
            .onAppear {
                youtubeService.fetchPopularVideos { fetchedVideos in
                    DispatchQueue.main.async {
                        self.videos = fetchedVideos ?? []
                    }
                }
            }
        }
    }
}

struct PopularVideosView_Previews: PreviewProvider {
    static var previews: some View {
        PopularVideosView()
    }
}
