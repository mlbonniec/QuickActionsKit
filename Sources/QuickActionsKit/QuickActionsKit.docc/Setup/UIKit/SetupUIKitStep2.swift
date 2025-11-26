import UIKit
import QuickActionsKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Properties
    private var manager: QuickActionsManager<MyQuickActions, SceneDelegate>?

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
}
