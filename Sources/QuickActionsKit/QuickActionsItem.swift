//
//  QuickActionsItem.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

struct QuickActionsItem<T> where T: RawRepresentable, T.RawValue == String {
    // MARK: Properties
    public let type: T

    public let title: String

    public let subtitle: String?

    public let isAvailable: Bool

    public let icon: Icon?

    // MARK: Lifecycle
    init(
        type: T,
        title: String,
        subtitle: String? = nil,
        isAvailable: Bool = true,
        icon: Icon? = nil
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.isAvailable = isAvailable
        self.icon = icon
    }
}

extension QuickActionsItem {
    // MARK: Data
    public enum Icon {
        case type(UIApplicationShortcutIcon.IconType)
        case systemName(String)
        case template(String)
    }
}
