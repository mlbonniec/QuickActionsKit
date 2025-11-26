//
//  QuickActions.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

/// A protocol that defines a collection of Quick Actions to expose to the system.
///
/// Conform to `QuickActions` to provide a set of app-specific quick actions
/// (e.g., Home screen quick actions on iOS) that can be transformed into
/// `UIApplicationShortcutItem` instances and presented to the user.
///
/// The protocol is generic over an `ActionType` that must conform to
/// `QuickActionType`, allowing you to define a strongly-typed domain of actions
/// for your feature or application.
///
/// Usage:
/// - Implement `actions()` to return a unique set of `QuickActionsItem<ActionType>`.
/// - The items will be mapped to `UIApplicationShortcutItem` and truncated to `limit`.
///
/// - Note: The order of the returned items may affect which actions are shown
///   when exceeding the limit; ensure `actions()` returns items in your desired priority.
///
/// - SeeAlso: `QuickActionType`, `QuickActionsItem`, `UIApplicationShortcutItem`
public protocol QuickActions<ActionType> {
    /// The associated action type describing the domain of quick actions.
    ///
    /// This type must conform to `QuickActionType` and typically represents
    /// the cases or identifiers for the actions your app supports.
    associatedtype ActionType: QuickActionType
    
    /// The maximum number of quick actions to expose.
    ///
    /// This value is used to limit the number of actions that are
    /// ultimately surfaced to the system. Implement to customize based on your
    /// product needs or platform constraints.
    ///
    /// - Default: `Int.max`
    var limit: Int { get }
    
    /// Provides the full set of available quick actions for this context.
    ///
    /// - Returns: A `Set` of `QuickActionsItem<ActionType>` representing unique actions.
    /// - Important: Use a `Set` to avoid duplicate actions and to emphasize uniqueness.
    /// - Note: The resulting set may be truncated to `limit` before being surfaced.
    func actions() -> Set<QuickActionsItem<ActionType>>
}

/// The default implementations for `QuickActions`.
public extension QuickActions {
    /// The default maximum number of quick actions.
    ///
    /// - Note: Implement in your conforming type to change the limit.
    var limit: Int { Int.max }
}

/// Internal conveniences for transforming actions into system shortcut items.
extension QuickActions {
    
    /// A mapped array of `UIApplicationShortcutItem` created from `actions()`,
    /// limited to `limit` items.
    ///
    /// - Discussion: This property maps each `QuickActionsItem` to a
    ///   `UIApplicationShortcutItem` using `QuickActionsMapper.map`, filters out
    ///   any that cannot be mapped, preserves the original ordering provided by
    ///   `actions()`, and then truncates to the configured `limit`.
    ///
    /// - Important: This property is intended for internal use when integrating
    ///   with system APIs. Prefer implementing `actions()` when defining behavior.
    var shortcutItems: [UIApplicationShortcutItem] {
        Array(
            actions()
                .compactMap(QuickActionsMapper.map)
                .prefix(limit)
        )
    }
}
