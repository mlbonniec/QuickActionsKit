//
//  QuickActionsHandler.swift
//  QuickActionsKit
//
//  Created by Mathis Le Bonniec on 11/26/25.
//

import Foundation

@MainActor
public protocol QuickActionsHandler {
    associatedtype ActionType: QuickActionType

    func handle(_ action: ActionType, userInfo: [String: NSSecureCoding]?) async -> Bool
}

