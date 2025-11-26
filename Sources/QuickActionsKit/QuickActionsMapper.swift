//
//  QuickActionsMapper.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

enum QuickActionsMapper {
    // MARK: Methods
    /// Map a `QuickActionItem` object into a `UIApplicationShortcutItem`.
    static func map<T>(
        from item: QuickActionsItem<T>
    ) -> UIApplicationShortcutItem? where T: QuickActionType {
        guard item.availability() else { return nil }

        return UIApplicationShortcutItem(
            type: item.type.rawValue,
            localizedTitle: item.title,
            localizedSubtitle: item.subtitle,
            icon: map(from: item.icon),
            userInfo: [:]
        )
    }

    // MARK: Private Methods
    /// Map a `QuickActionsItem.Icon` object into a `UIApplicationShortcutIcon`.
    ///
    /// - Returns: `nil` if the provided `icon` is also nil.
    private static func map<T>(
        from icon: QuickActionsItem<T>.Icon?
    ) -> UIApplicationShortcutIcon? where T: QuickActionType {
        guard let icon else { return nil }

        return switch icon {
        case .type(let type):
            UIApplicationShortcutIcon(type: type)
        case .systemName(let name):
            UIApplicationShortcutIcon(systemImageName: name)
        case .template(let name):
            UIApplicationShortcutIcon(templateImageName: name)
        }
    }
}
