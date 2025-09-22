import Foundation

final class AppCoordinator: ObservableObject {
    let map = MapCoordinator()
    let search = TripCoordinator()
    let favorites = FavoritesCoordinator()
    let profile = ProfileCoordinator()
}
