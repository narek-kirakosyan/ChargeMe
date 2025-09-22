import SwiftUI

struct AppRootView: View {
    @StateObject var appCoordinator = AppCoordinator()

    var body: some View {
        TabView {
            MapTabView()
                .tabItem { Label("Map", systemImage: "map") }
                .environmentObject(appCoordinator.map)

            TripsTabView()
                .tabItem { Label("Trip", systemImage: "bolt.car") }
                .environmentObject(appCoordinator.search)
            
            FavoritesTabView()
                .tabItem { Label("Favorites", systemImage: "star") }
                .environmentObject(appCoordinator.favorites)

            ProfileTabView()
                .tabItem { Label("Profile", systemImage: "person") }
                .environmentObject(appCoordinator.profile)
        }
    }
}
