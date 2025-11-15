//
//  ChaptersViewModelTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
import Combine
@testable import SwiftChapterUSA_finder

class ChaptersViewModelTests: XCTestCase {
    var viewModel: ChaptersViewModel!
    var mockChapterService: MockChapterService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockChapterService = MockChapterService()
        viewModel = ChaptersViewModel(chapterService: mockChapterService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockChapterService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFilteredChapters_NoFilter() {
        let chapters = viewModel.filteredChapters
        
        XCTAssertEqual(chapters.count, 2)
        XCTAssertTrue(viewModel.hasChapters)
    }
    
    func testFilteredChapters_StateFilter() {
        viewModel.selectedState = "California"
        
        let chapters = viewModel.filteredChapters
        
        XCTAssertEqual(chapters.count, 1)
        XCTAssertEqual(chapters.first?.state, "California")
    }
    
    func testFilteredChapters_SearchText() {
        viewModel.searchText = "UCLA"
        
        let chapters = viewModel.filteredChapters
        
        XCTAssertEqual(chapters.count, 1)
        XCTAssertTrue(chapters.first?.university?.contains("UCLA") ?? false)
    }
    
    func testFilteredChapters_StateAndSearch() {
        viewModel.selectedState = "California"
        viewModel.searchText = "Los Angeles"
        
        let chapters = viewModel.filteredChapters
        
        XCTAssertEqual(chapters.count, 1)
        XCTAssertEqual(chapters.first?.city, "Los Angeles")
    }
    
    func testFilteredChapters_NoResults() {
        viewModel.searchText = "NonexistentChapter"
        
        let chapters = viewModel.filteredChapters
        
        XCTAssertEqual(chapters.count, 0)
        XCTAssertFalse(viewModel.hasChapters)
    }
    
    func testClearSearch() {
        viewModel.searchText = "Test"
        viewModel.selectedState = "California"
        
        viewModel.clearSearch()
        
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.selectedState, "All States")
    }
    
    func testChaptersCount() {
        XCTAssertEqual(viewModel.chaptersCount, 2)
        
        viewModel.selectedState = "California"
        XCTAssertEqual(viewModel.chaptersCount, 1)
    }
}
