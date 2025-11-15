//
//  CreateChapterViewModelTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
import Combine
@testable import SwiftChapterUSA_finder

class CreateChapterViewModelTests: XCTestCase {
    var viewModel: CreateChapterViewModel!
    var mockChapterService: MockChapterService!
    
    override func setUp() {
        super.setUp()
        mockChapterService = MockChapterService()
        viewModel = CreateChapterViewModel(chapterService: mockChapterService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockChapterService = nil
        super.tearDown()
    }
    
    func testFormValidation_ValidInput() {
        viewModel.chapterName = "New Chapter"
        viewModel.city = "Boston"
        viewModel.presidentName = "John Doe"
        viewModel.contactEmail = "john@example.com"
        viewModel.description = "Test description"
        
        XCTAssertTrue(viewModel.isFormValid)
    }
    
    func testFormValidation_MissingName() {
        viewModel.chapterName = ""
        viewModel.city = "Boston"
        viewModel.presidentName = "John Doe"
        viewModel.contactEmail = "john@example.com"
        viewModel.description = "Test description"
        
        XCTAssertFalse(viewModel.isFormValid)
    }
    
    func testFormValidation_InvalidEmail() {
        viewModel.chapterName = "New Chapter"
        viewModel.city = "Boston"
        viewModel.presidentName = "John Doe"
        viewModel.contactEmail = "invalidemail"
        viewModel.description = "Test description"
        
        XCTAssertFalse(viewModel.isFormValid)
    }
    
    func testCreateChapter_Success() {
        viewModel.chapterName = "New Chapter"
        viewModel.city = "Boston"
        viewModel.selectedState = "Massachusetts"
        viewModel.presidentName = "John Doe"
        viewModel.contactEmail = "john@example.com"
        viewModel.description = "Test description"
        
        let result = viewModel.createChapter()
        
        XCTAssertTrue(result)
        XCTAssertTrue(mockChapterService.addChapterCalled)
        XCTAssertEqual(mockChapterService.chapters.count, 3) // 2 initial + 1 new
        XCTAssertTrue(viewModel.showingAlert)
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testCreateChapter_Failure() {
        // Invalid form
        viewModel.chapterName = ""
        
        let result = viewModel.createChapter()
        
        XCTAssertFalse(result)
        XCTAssertFalse(mockChapterService.addChapterCalled)
    }
    
    func testClearForm() {
        viewModel.chapterName = "Test"
        viewModel.city = "Boston"
        viewModel.description = "Description"
        
        viewModel.clearForm()
        
        XCTAssertEqual(viewModel.chapterName, "")
        XCTAssertEqual(viewModel.city, "")
        XCTAssertEqual(viewModel.description, "")
    }
}
