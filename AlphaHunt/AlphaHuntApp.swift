//
//  AlphaHuntApp.swift
//  AlphaHunt
//
//  Created by Kern Redd on 10/2/23.
//

import SwiftUI

@main
struct AlphaHuntApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: AlphaHunt())
        }
    }
}
