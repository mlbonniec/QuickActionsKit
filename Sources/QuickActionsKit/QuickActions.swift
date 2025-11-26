//
//  QuickActions.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

/// The protocol defining the quick actions list and actions for your application.
/// 
/// ```swift
/// enum MyQuickActionsType: String, QuickActionsType {
///     // …
/// }
///
/// final class MyQuickActions: QuickActions<MyQuickActionsType> {
///     // …
/// }
/// ```
public protocol QuickActions<ActionType> {
    associatedtype ActionType: QuickActionType

    /// The limit of actions to display.
    var limit: Int { get }

    /// The list of dynamic actions.
    func actions() -> Set<QuickActionsItem<ActionType>>
}

public extension QuickActions {
    var limit: Int { 4 }
}

extension QuickActions {
    var shortcutItems: [UIApplicationShortcutItem] {
        Array(
            actions()
                .compactMap(QuickActionsMapper.map)
                .prefix(limit)
        )
    }
}
