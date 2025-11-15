//
//  ContentView.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showDisclaimer = true
    
    var body: some View {
        Group {
            if showDisclaimer {
                DisclaimerView(isPresented: $showDisclaimer)
            } else if authManager.isAuthenticated {
                MainTabView()
            } else {
                AuthenticationView()
            }
        }
    }
}
