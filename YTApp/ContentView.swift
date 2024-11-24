import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
          
            PopularVideosView()
                .tabItem {
                    Label("Popular", systemImage: "star.fill")
                }
            
            
            SearchVideosView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
