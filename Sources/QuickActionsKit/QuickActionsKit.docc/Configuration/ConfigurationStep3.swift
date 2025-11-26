import QuickActionsKit

enum MyQuickActionsType: String, QuickActionType {
    case home
    case create
}

final class MyQuickActions: QuickActions {
    func getActions() -> Set<QuickActionsItem<MyQuickActionsType>> {
        [
            QuickActionsItem<MyQuickActionsType>(
                type: .home,
                title: "Go Home",
                subtitle: "Redirect to Home",
                icon: nil
            ),
            QuickActionsItem<MyQuickActionsType>(
                type: .create,
                title: "Create",
                subtitle: nil,
                icon: .systemName("plus"),
                availability: {
                    MyApplicationSingleton.current.isUserLogged
                }
            )
        ]
    }
}
