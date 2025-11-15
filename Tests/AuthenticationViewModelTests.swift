//
//  AuthenticationViewModelTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
import Combine
@testable import SwiftChapterUSA_finder

class AuthenticationViewModelTests: XCTestCase {
    var viewModel: AuthenticationViewModel!
    var mockAuthService: MockAuthenticationService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationService()
        viewModel = AuthenticationViewModel(authService: mockAuthService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockAuthService = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Login Tests
    
    func testLoginFormValidation_ValidInput() {
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        
        XCTAssertTrue(viewModel.isLoginFormValid)
    }
    
    func testLoginFormValidation_InvalidEmail() {
        viewModel.email = "invalidemail"
        viewModel.password = "password123"
        
        XCTAssertFalse(viewModel.isLoginFormValid)
    }
    
    func testLoginFormValidation_EmptyPassword() {
        viewModel.email = "test@example.com"
        viewModel.password = ""
        
        XCTAssertFalse(viewModel.isLoginFormValid)
    }
    
    func testLoginSuccess() {
        viewModel.email = "test@example.com"
        viewModel.password = "password"
        
        viewModel.login()
        
        XCTAssertTrue(mockAuthService.loginCalled)
        XCTAssertTrue(mockAuthService.isAuthenticated)
        XCTAssertNotNil(mockAuthService.currentUser)
    }
    
    func testLoginFailure() {
        viewModel.email = "wrong@example.com"
        viewModel.password = "wrongpassword"
        
        viewModel.login()
        
        XCTAssertTrue(mockAuthService.loginCalled)
        XCTAssertFalse(mockAuthService.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    // MARK: - Registration Tests
    
    func testRegistrationFormValidation_ValidInput() {
        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "john@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        XCTAssertTrue(viewModel.isRegistrationFormValid)
    }
    
    func testRegistrationFormValidation_PasswordTooShort() {
        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "john@example.com"
        viewModel.password = "pass"
        viewModel.confirmPassword = "pass"
        
        XCTAssertFalse(viewModel.isRegistrationFormValid)
    }
    
    func testRegistrationFormValidation_PasswordMismatch() {
        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "john@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "different123"
        
        XCTAssertFalse(viewModel.isRegistrationFormValid)
    }
    
    func testRegistrationSuccess() {
        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        viewModel.email = "john@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        viewModel.selectedState = "California"
        
        viewModel.register()
        
        XCTAssertTrue(mockAuthService.registerCalled)
        XCTAssertTrue(mockAuthService.isAuthenticated)
        XCTAssertEqual(mockAuthService.currentUser?.firstName, "John")
        XCTAssertEqual(mockAuthService.currentUser?.lastName, "Doe")
    }
    
    // MARK: - Other Tests
    
    func testLogout() {
        viewModel.logout()
        
        XCTAssertTrue(mockAuthService.logoutCalled)
    }
    
    func testToggleMode() {
        XCTAssertTrue(viewModel.isLoginMode)
        
        viewModel.toggleMode()
        
        XCTAssertFalse(viewModel.isLoginMode)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testClearForm() {
        viewModel.email = "test@example.com"
        viewModel.password = "password"
        viewModel.firstName = "John"
        viewModel.errorMessage = "Some error"
        
        viewModel.clearForm()
        
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertEqual(viewModel.firstName, "")
        XCTAssertNil(viewModel.errorMessage)
    }
}
