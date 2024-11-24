import SwiftUI
import Combine

class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = [] 
    private let youTubeService = YouTubeService()

    
    func searchVideos(query: String) {
        youTubeService.searchVideos(query: query) { [weak self] fetchedVideos in
            DispatchQueue.main.async {
                if let videos = fetchedVideos {
                    self?.videos = videos
                } else {
                    self?.videos = []
                    print("No videos found")
                }
            }
        }
    }
}
