import SwiftUI

struct ContentView: View {
    @StateObject private var saved = Saved()
    @StateObject private var visited = Visited()
    @StateObject private var hasVoted = Voting()
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchPage()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            JourneyView()
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("Journey")
                }
        }
        .environmentObject(saved)
        .environmentObject(visited)
        .environmentObject(hasVoted)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
