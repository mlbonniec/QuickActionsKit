![Cover](./Sources/QuickActionsKit/QuickActionsKit.docc/Resources/Cover.png)

# QuickActionsKit

A lightweight Swift library for configuring and handling Home Screen Quick Actions with minimal setup.

## Overview

QuickActionsKit simplifies the implementation of 3D Touch and long-press shortcuts on your app's Home Screen icon. Whether you're building with SwiftUI or UIKit, QuickActionsKit provides a clean, declarative API to define dynamic quick actions that respond to your application's state.

### Key Features

- **Universal compatibility**: Works seamlessly with both SwiftUI and UIKit projects
- **Dynamic actions**: Update quick actions based on your app's current state
- **Type-safe**: Leverage Swift's type system to prevent runtime errors
- **Lightweight**: Minimal overhead with a focused API surface

### Documentation

You can find the full documentation and usage examples on the [QuickActionsKit Documentation](https://mlbonniec.github.io/QuickActionsKit/).

#### Tutorials
- [Learn how to setup QuickActions for your application.](https://mlbonniec.github.io/QuickActionsKit/tutorials/setup)

#### Quick Example

Define your QuickActions, with a type, title, subtitle, icon, availability and behaviors.

```swift
enum MyQuickActionsType: String, QuickActionType {
    case editor
}

class MyQuickActions: QuickActions {
    var actions: Set<QuickActionsItem<MyQuickActionsType>> = [
        QuickActionsItem<MyQuickActionsType>(
            type: .editor,
            title: "Edit",
            subtitle: nil,
            icon: nil,
            isAvailable: MyApplicationSingleton.current.isUserLogged
        )
    ]

    func perform(for type: MyQuickActionsType, with userInfo: [String:NSSecureCoding]?) -> Bool {
        switch type {
        case .editor:
            print("Navigate to the editor")
        }
    }
}
```

Then, provide your QuickActions to the `QuickActionsManager` and call `perform(action:)` and `update()` in your application's lifecycle.

```swift
let actions: QuickActionsManager = QuickActionsManager(HMQuickActions())

if let shortcutItem = connectionOptions.shortcutItem {
    actions.perform(action: shortcutItem)
}

actions.perform(action: shortcutItem)
actions.update()
```

### License

This project is licensed under MIT.  
See [LICENSE](./LICENSE) for more details.
