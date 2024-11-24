import SwiftUI
import WebKit

struct VideoWebView: View {
    let videoId: String
    
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://www.youtube.com/watch?v=\(videoId)")!)
        }
        .navigationBarTitle("Video", displayMode: .inline)
    }
}


struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
