//
//  QuickActionsKit.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

/// The manager used to configure, update and perform action for quick actions.
@MainActor
final public class QuickActionsManager<Actions, Handler>
where
    Actions: QuickActions,
    Handler: QuickActionsHandler,
    Handler.ActionType == Actions.ActionType
{
    // MARK: Properties
    private var configuration: Actions
    private var handler: Handler

    // MARK: Lifecycle
    public init(_ configuration: Actions, handler: Handler) {
        self.configuration = configuration
        self.handler = handler
    }

    // MARK: Methods
    /// Update your application quick actions based on your current application state.
    ///
    /// - Note: You should call this method once your application/scene is resigning.
    public func update() {
        UIApplication.shared.shortcutItems = configuration.shortcutItems
    }

    /// The method to call when the application is opened through a quick action.
    @discardableResult
    public func handle(shortcut: UIApplicationShortcutItem) async -> Bool {
        guard let type = Actions.ActionType(rawValue: shortcut.type) else {
            assert(false, "Failed to parse type property from UIApplicationShortcutItem.")
            return false
        }

        return await handler.handle(type, userInfo: shortcut.userInfo)
    }
}
