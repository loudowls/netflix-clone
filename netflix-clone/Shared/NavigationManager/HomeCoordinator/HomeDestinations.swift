//
//  HomeDestinations.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 31/12/25.
//

import SwiftUI
import SwiftUINavigation

enum HomeDestinations: Hashable {
    case moveDetails(key: String)
}

typealias HomeCoordinator =  NavigationCoordinator<HomeDestinations>

extension EnvironmentValues {
    @Entry var homeCoordinator: HomeCoordinator = HomeCoordinator() 
}
