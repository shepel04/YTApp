import SwiftUI

struct SearchVideosView: View {
    @State private var query = ""
    @State private var videos: [Video] = []
    @State private var isLoading = false
    @State private var searchTimer: Timer? = nil
    let youtubeService = YouTubeService()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for videos...", text: $query)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: query) { newQuery in
                        
                        searchTimer?.invalidate()
                        if newQuery.count > 1 { // search after 2 symbols
                            isLoading = true
                            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                youtubeService.searchVideos(query: newQuery) { fetchedVideos in
                                    DispatchQueue.main.async {
                                        self.videos = fetchedVideos ?? []
                                        self.isLoading = false
                                    }
                                }
                            }
                        } else {
                            self.videos = []
                            isLoading = false
                        }
                    }

                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }

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
            }
            .navigationBarTitle("Search Videos")
        }
    }
}

struct SearchVideosView_Previews: PreviewProvider {
    static var previews: some View {
        SearchVideosView()
    }
}
