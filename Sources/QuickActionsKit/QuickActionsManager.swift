
//
//  QuickActionsKit.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

final public class QuickActionsManager<T> where T: QuickActions {
    // MARK: Properties
    private var configuration: T

    // MARK: Lifecycle
    public init(_ configuration: T) {
        self.configuration = configuration
    }

    // MARK: Methods
    @MainActor
    public func update() {
        UIApplication.shared.shortcutItems = configuration.actions.compactMap(QuickActionsMapper.map)
    }

    @discardableResult
    public func perform(for action: UIApplicationShortcutItem) -> Bool {
        guard let type = T.T(rawValue: action.type) else {
            assert(false, "Failed to parse type property from UIApplicationShortcutItem.")
            return false
        }

        return configuration.performAction(for: type, with: action.userInfo)
    }
}
