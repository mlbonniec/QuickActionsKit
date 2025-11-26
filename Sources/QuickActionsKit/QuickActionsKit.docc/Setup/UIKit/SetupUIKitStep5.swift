import QuickActionsKit

@MainActor
class SceneDelegate: UIResponder, UIWindowSceneDelegate {}

extension SceneDelegate: QuickActionsHandler {
    func handle(_ action: MyQuickActionsType, userInfo: [String:any NSSecureCoding]?) async -> Bool {
        switch action {
        case .home:
            // …
        case .create:
            // …
        }

        return true
    }
}
