//
//  netflix_cloneApp.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 23/12/25.
//

import SwiftUI
import ToastUI

@main
struct netflix_cloneApp: App {
   
    init() {
        loadRocketSimConnect()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .setupToastUI()
        }
    }
    
    private func loadRocketSimConnect() {
        #if DEBUG
        guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
            print("Failed to load linker framework")
            return
        }
        print("RocketSim Connect successfully linked")
        #endif
    }
}



