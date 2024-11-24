import Foundation
import Alamofire

class YouTubeService {
    let apiKey = "YOUR_API_KEY"
    
    func fetchTopVideos(completion: @escaping ([Video]) -> Void) {
        let url = "https://www.googleapis.com/youtube/v3/videos"
        let parameters: [String: Any] = [
            "part": "snippet",
            "chart": "mostPopular",
            "maxResults": 10,
            "regionCode": "US",
            "key": apiKey
        ]
        
        AF.request(url, parameters: parameters).responseDecodable(of: VideoList.self) { response in
            switch response.result {
            case .success(let videoList):
                let videos = videoList.items.map { Video(title: $0.snippet.title, description: $0.snippet.description, thumbnailURL: $0.snippet.thumbnails.defaultThumbnail.url, videoId: $0.id.videoId) }
                completion(videos)
            case .failure(let error):
                print("Error fetching videos: \(error)")
                completion([])
            }
        }
    }
}
