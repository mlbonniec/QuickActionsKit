//
//  QuickActionsItem.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

public protocol QuickActionType: Sendable, RawRepresentable, Hashable where RawValue == String {}

public struct QuickActionsItem<T>: Hashable where T: QuickActionType {
    // MARK: Properties
    public let type: T

    public let title: String

    public let subtitle: String?

    public let icon: Icon?

    public let isAvailable: Bool

    // MARK: Lifecycle
    public init(
        type: T,
        title: String,
        subtitle: String? = nil,
        icon: Icon? = nil,
        isAvailable: Bool = true
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.isAvailable = isAvailable
    }
}

extension QuickActionsItem {
    // MARK: Data
    public enum Icon: Hashable {
        case type(UIApplicationShortcutIcon.IconType)
        case systemName(String)
        case template(String)
    }
}
