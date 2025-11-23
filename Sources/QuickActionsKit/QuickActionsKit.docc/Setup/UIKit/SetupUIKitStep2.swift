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
}
