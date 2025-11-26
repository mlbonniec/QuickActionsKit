//
//  QuickActionsHandler.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/26/25.
//

import Foundation

/// A protocol that defines a handler for executing quick actions within your app.
/// 
/// Conform to `QuickActionsHandler` to process and respond to a specific set of quick actions,
/// typically originating from system integrations such as Home screen quick actions, widgets,
/// notifications, or app-specific shortcuts. Implementers specify the concrete action type via
/// the `ActionType` associated type and provide logic to handle those actions asynchronously.
///
/// This protocol is annotated with `@MainActor`, which means conforming types and their methods
/// are isolated to the main actor. This ensures UI updates and other main-thread–bound work
/// can be performed safely while handling actions.
///
/// - Note: `ActionType` must conform to `QuickActionType`, which defines the model or descriptor
///   for an action that can be invoked. Make sure your `ActionType` encapsulates all the
///   information needed to execute the action.
///
/// - SeeAlso: `QuickActionType`
///
/// ### Example
/// ```swift
/// enum MyQuickActionsType: String, QuickActionType {
///     case foo, bar
/// }
///
/// extension SceneDelegate: QuickActionsHandler {
///     func handle(_ action: MyQuickActionsType, userInfo: [String:NSSecureCoding]?) async -> Bool {
///         switch action {
///         case .foo:
///             // …
///         case .bar:
///             // …
///         }
///
///         return true
///     }
/// }
/// ```
@MainActor
public protocol QuickActionsHandler {
    /// The concrete quick action type that this handler can process.
    ///
    /// Conforming types set `ActionType` to a specific type that models the action
    /// to handle. This type must conform to `QuickActionType`.
    associatedtype ActionType: QuickActionType
    
    /// Handles a quick action asynchronously on the main actor.
    ///
    /// Implement this method to execute the logic associated with the given `action`.
    /// Use `userInfo` to receive additional, optional metadata that may be required
    /// to complete the action (for example, identifiers, prefilled content, or flags).
    ///
    /// - Parameters:
    ///   - action: The quick action to be handled. Its type is defined by `ActionType`.
    ///   - userInfo: An optional dictionary of additional information provided with the
    ///               action. Values must conform to `NSSecureCoding` to ensure secure
    ///               serialization and transport.
    ///
    /// - Returns: `true` if the action was recognized and successfully handled; `false`
    ///            if the action could not be handled or was not applicable.
    ///
    /// - Note: Since this method is `async` and the protocol is `@MainActor`,
    ///              you can safely perform UI operations directly within the handler.
    func handle(_ action: ActionType, userInfo: [String:NSSecureCoding]?) async -> Bool
}
