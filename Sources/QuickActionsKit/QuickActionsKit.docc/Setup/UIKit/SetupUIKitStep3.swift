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
        self.manager = QuickActionsManager(HMQuickActions(), handler: self)

        if let shortcutItem = connectionOptions.shortcutItem {
            Task {
                await manager?.handle(shortcut: shortcutItem)
            }
        }

        // …
    }

    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem
    ) async -> Bool {
        await manager?.handle(shortcut: shortcutItem) ?? false
    }
}
