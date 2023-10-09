//
//  MagicAppApp.swift
//  MagicApp
//
//  Created by Cường Trần on 17/08/2023.
//

import SwiftUI

@main
struct MagicAppApp: App {
    @StateObject var mainViewVM = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabbarView()
            }
            .environmentObject(mainViewVM)
        }
    }
}
