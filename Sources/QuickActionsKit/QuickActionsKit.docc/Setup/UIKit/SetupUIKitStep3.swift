import UIKit
import QuickActionsKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Properties
    private let actions: QuickActionsManager = QuickActionsManager(HMQuickActions())

    // MARK: Lifecycle
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let shortcutItem = connectionOptions.shortcutItem {
            actions.perform(action: shortcutItem)
        }

        // …
    }

    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem
    ) async -> Bool {
        actions.perform(action: shortcutItem)
    }
}
