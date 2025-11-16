//
//  ProfileViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var showingEditProfile = false
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var selectedState = "Alabama"
    @Published var university = ""
    
    private let authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
        loadUserData()
    }
    
    var currentUser: User? {
        authService.currentUser
    }
    
    var fullName: String {
        currentUser?.fullName ?? "User"
    }
    
    var email: String {
        currentUser?.email ?? ""
    }
    
    var state: String {
        currentUser?.state ?? ""
    }
    
    var memberSince: String {
        currentUser?.dateJoined.formatted(date: .long, time: .omitted) ?? ""
    }
    
    func loadUserData() {
        guard let user = authService.currentUser else { return }
        firstName = user.firstName
        lastName = user.lastName
        selectedState = user.state
        university = user.university ?? ""
    }
    
    func saveProfile() -> Bool {
        guard var user = authService.currentUser else { return false }
        
        user.firstName = firstName
        user.lastName = lastName
        user.state = selectedState
        user.university = university.isEmpty ? nil : university
        
        authService.updateUser(user)
        return true
    }
    
    func logout() {
        authService.logout()
    }
    
    var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty
    }
}
