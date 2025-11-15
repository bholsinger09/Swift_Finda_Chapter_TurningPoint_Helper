//
//  ProfileViewModelTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
import Combine
@testable import SwiftChapterUSA_finder

class ProfileViewModelTests: XCTestCase {
    var viewModel: ProfileViewModel!
    var mockAuthService: MockAuthenticationService!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationService()
        mockAuthService.currentUser = User(
            email: "test@example.com",
            firstName: "John",
            lastName: "Doe",
            state: "California",
            university: "UCLA"
        )
        mockAuthService.isAuthenticated = true
        
        viewModel = ProfileViewModel(authService: mockAuthService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testUserData() {
        XCTAssertEqual(viewModel.fullName, "John Doe")
        XCTAssertEqual(viewModel.email, "test@example.com")
        XCTAssertEqual(viewModel.state, "California")
        XCTAssertNotNil(viewModel.currentUser)
    }
    
    func testLoadUserData() {
        viewModel.loadUserData()
        
        XCTAssertEqual(viewModel.firstName, "John")
        XCTAssertEqual(viewModel.lastName, "Doe")
        XCTAssertEqual(viewModel.selectedState, "California")
        XCTAssertEqual(viewModel.university, "UCLA")
    }
    
    func testSaveProfile() {
        viewModel.firstName = "Jane"
        viewModel.lastName = "Smith"
        viewModel.selectedState = "Texas"
        viewModel.university = "UT Austin"
        
        let result = viewModel.saveProfile()
        
        XCTAssertTrue(result)
        XCTAssertTrue(mockAuthService.updateUserCalled)
        XCTAssertEqual(mockAuthService.currentUser?.firstName, "Jane")
        XCTAssertEqual(mockAuthService.currentUser?.lastName, "Smith")
    }
    
    func testIsFormValid() {
        viewModel.firstName = "John"
        viewModel.lastName = "Doe"
        
        XCTAssertTrue(viewModel.isFormValid)
        
        viewModel.firstName = ""
        XCTAssertFalse(viewModel.isFormValid)
    }
    
    func testLogout() {
        viewModel.logout()
        
        XCTAssertTrue(mockAuthService.logoutCalled)
    }
}
