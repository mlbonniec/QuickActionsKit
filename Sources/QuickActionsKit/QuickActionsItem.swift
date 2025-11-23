//
//  QuickActionsItem.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

/// Represents the enum containing all the quick action types available for your application.
public protocol QuickActionType: Sendable, RawRepresentable, Hashable where RawValue == String {}

/// Represents a quick action item shown in the menu. 
public struct QuickActionsItem<T>: Hashable where T: QuickActionType {
    // MARK: Properties
    /// The unique quick action type.
    public let type: T

    /// The quick action title, visible in the menu.
    public let title: String

    /// The optional quick action subtitle, visible in the menu.
    public let subtitle: String?

    /// The optional quick action icon.
    public let icon: Icon?

    /// The quick action availability.
    public let availability: Bool

    // MARK: Lifecycle
    /// Construct a new `QuickActionsItem` with all the properties.
    public init(
        type: T,
        title: String,
        subtitle: String? = nil,
        icon: Icon? = nil,
        availability: Bool = true
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.availability = availability
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
