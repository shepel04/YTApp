import Foundation

struct YTSearchResponse: Codable {
    let items: [SearchResultItem]
}

struct SearchResultItem: Codable {
    let id: VideoID
    let snippet: Snippet
}

struct VideoID: Codable {
    let videoId: String
}

struct YTVideoResponse: Codable {
    let items: [Video]
}

struct Video: Identifiable, Codable {
    let id: String
    let snippet: Snippet
    let statistics: Statistics
}

struct Snippet: Codable {
    let title: String
    let description: String
    let thumbnails: Thumbnails
}

struct Thumbnails: Codable {
    let high: ThumbnailDetail
}

struct ThumbnailDetail: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct Statistics: Codable {
    let viewCount: String
}
