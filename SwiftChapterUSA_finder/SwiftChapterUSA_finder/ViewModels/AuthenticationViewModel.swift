//
//  AuthenticationViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var selectedState = "Alabama"
    @Published var university = ""
    @Published var errorMessage: String?
    @Published var isLoginMode = true
    
    private let authService: AuthenticationServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    var isAuthenticated: Bool {
        authService.isAuthenticated
    }
    
    var currentUser: User? {
        authService.currentUser
    }
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Validation
    
    var isLoginFormValid: Bool {
        !email.isEmpty && email.contains("@") && !password.isEmpty
    }
    
    var isRegistrationFormValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !email.isEmpty &&
        email.contains("@") &&
        password.count >= 6 &&
        password == confirmPassword
    }
    
    // MARK: - Actions
    
    func login() {
        guard isLoginFormValid else {
            errorMessage = "Please enter valid email and password"
            return
        }
        
        authService.login(email: email, password: password)
        errorMessage = authService.errorMessage
    }
    
    func register() {
        guard isRegistrationFormValid else {
            if firstName.isEmpty || lastName.isEmpty {
                errorMessage = "Please enter your name"
            } else if !email.contains("@") {
                errorMessage = "Please enter a valid email"
            } else if password.count < 6 {
                errorMessage = "Password must be at least 6 characters"
            } else if password != confirmPassword {
                errorMessage = "Passwords do not match"
            }
            return
        }
        
        authService.register(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            state: selectedState,
            university: university.isEmpty ? nil : university
        )
    }
    
    func logout() {
        authService.logout()
    }
    
    func toggleMode() {
        isLoginMode.toggle()
        errorMessage = nil
        password = ""
        confirmPassword = ""
    }
    
    func clearForm() {
        email = ""
        password = ""
        confirmPassword = ""
        firstName = ""
        lastName = ""
        university = ""
        errorMessage = nil
    }
}
