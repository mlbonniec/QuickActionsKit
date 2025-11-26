//
//  QuickActionsItem.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/22/25.
//

import UIKit

/// Represents the enum containing all the quick action types available for your application.
/// A marker protocol that identifies a type-safe identifier for Home Screen quick actions.
///
/// Conform your enumeration to `QuickActionType` to declare the complete, strongly-typed
/// set of quick actions your app supports. The protocol refines several standard Swift
/// protocols to ensure identifiers are safe to use across threads, easy to store, and
/// stable to serialize:
/// - `RawRepresentable` with `RawValue == String`: Each case must map to a unique string
///   value, which is used by the system (e.g., `UIApplicationShortcutItem.type`) and for
///   persistence or deep linking.
/// - `Hashable`: Enables use in sets, dictionaries, and as stable identifiers.
/// - `Sendable`: Ensures values can safely cross concurrency boundaries.
///
/// Typical usage:
/// ```swift
/// enum AppQuickAction: String, QuickActionType {
///     case note, search, favorites
/// }
/// ```
///
/// See also:
/// - ``QuickActionsItem`` for modeling a full quick action entry presented to the user.
public protocol QuickActionType: Sendable, RawRepresentable, Hashable where RawValue == String {}

/// Represents a quick action item shown in the menu. 
/// A value type that models a single Home Screen quick action entry for your app.
///
/// Use `QuickActionsItem` to describe the content and behavior of a quick action that
/// appears in the system-provided menu (for example, via Home Screen icon context menu).
/// Each item carries a strongly-typed identifier (`type`), user-visible strings (`title`
/// and optional `subtitle`), an optional icon, and a Boolean that indicates whether the
/// action is currently available.
///
/// - Generic Parameter:
///   - T: A concrete type conforming to ``QuickActionType`` that uniquely identifies
///         the action. This enables type-safe handling and pattern matching of actions.
///
/// The struct conforms to `Hashable`. Two `QuickActionsItem` values are considered equal
/// if, and only if, their `type` values are equal. This makes `type` the logical unique
/// identifier for items, which is useful when storing items in sets or using them as
/// dictionary keys.
///
/// Typical usage includes:
/// - Defining an enum that conforms to ``QuickActionType`` to enumerate all actions.
/// - Creating one `QuickActionsItem` per action with localized titles, optional subtitles,
///   and an appropriate icon.
/// - Toggling `availability` to dynamically include or exclude an action from the menu.
///
/// Example:
/// ```swift
/// enum AppQuickAction: String, QuickActionType {
///     case note, search, favorites
/// }
///
/// let item = QuickActionsItem<AppQuickAction>(
///     type: .note,
///     title: "New Note",
///     subtitle: "Create a blank note",
///     icon: .systemName("square.and.pencil"),
///     availability: true
/// )
/// ```
///
/// - Note: The `icon` supports multiple representations, including system icon names and
///   `UIApplicationShortcutIcon.IconType`, to integrate with the system quick action UI.
///   
/// - SeeAlso: ``QuickActionType`` and ``QuickActionsItem/Icon``
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

    static public func == (lhs: QuickActionsItem, rhs: QuickActionsItem) -> Bool {
        lhs.type == rhs.type
    }
}

extension QuickActionsItem {
    // MARK: Data
    /// Represents the visual symbol displayed alongside a quick action in the system menu.
    /// 
    /// Use `Icon` to describe how the quick action should appear visually. The enum supports
    /// multiple representations to align with system-provided icons and custom assets.
    ///
    /// Cases:
    /// - `type(UIApplicationShortcutIcon.IconType)`: Uses a predefined system shortcut icon
    ///   provided by UIKit. This is the most native option and ensures visual consistency
    ///   with system quick actions.
    /// - `systemName(String)`: Uses an SF Symbols system image by name (e.g., "square.and.pencil").
    ///   Prefer this when you want a modern, scalable symbol that follows system design.
    /// - `template(String)`: Uses the name of a templated image asset in your app bundle.
    ///   The image should be a monochrome, template-rendered asset suitable for tinting.
    ///
    /// Notes:
    /// - Not all SF Symbols are available on all platform versions. Ensure compatibility for
    ///   targeted iOS, iPadOS, or other Apple platforms.
    /// - Template images should be provided as single-color assets intended for tinting.
    /// - The exact rendering of the icon may vary based on the system UI and context.
    public enum Icon: Hashable {
        case type(UIApplicationShortcutIcon.IconType)
        case systemName(String)
        case template(String)
    }
}
