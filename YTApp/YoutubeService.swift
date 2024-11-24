import Foundation

class YouTubeService {
    private let apiKey = "AIzaSyCGuQ-A71R2av9DstrRGWnweeg7rNUZTDk"
    private let searchBaseURL = "https://www.googleapis.com/youtube/v3/search"
    private let videoBaseURL = "https://www.googleapis.com/youtube/v3/videos"
    
    
    func searchVideos(query: String, completion: @escaping ([Video]?) -> Void) {
        var urlComponents = URLComponents(string: searchBaseURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: "part", value: "snippet"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "maxResults", value: "10"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(YTSearchResponse.self, from: data)
                completion(searchResponse.items.map { item in
                    Video(id: item.id.videoId, snippet: item.snippet, statistics: Statistics(viewCount: "N/A"))
                })
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
   
    func fetchPopularVideos(completion: @escaping ([Video]?) -> Void) {
        var urlComponents = URLComponents(string: videoBaseURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: "part", value: "snippet,statistics"),
            URLQueryItem(name: "chart", value: "mostPopular"),
            URLQueryItem(name: "maxResults", value: "10"), 
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let videoResponse = try JSONDecoder().decode(YTVideoResponse.self, from: data)
                completion(videoResponse.items)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
