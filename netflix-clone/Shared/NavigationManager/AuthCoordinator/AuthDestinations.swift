//
//  AuthDestinations.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 23/12/25.
//

import SwiftUI
import SwiftUINavigation


enum AuthDestinations: Hashable {
    case onboarding
    case signin
    case signup
    case verifyEmail(email: String)
}

// This give us access of navigation stack and methods
typealias AuthCoordinator = NavigationCoordinator<AuthDestinations>

extension EnvironmentValues {
    @Entry var authCoordinator: AuthCoordinator = AuthCoordinator()
}
