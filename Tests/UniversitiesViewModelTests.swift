//
//  UniversitiesViewModelTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
import Combine
@testable import SwiftChapterUSA_finder

class UniversitiesViewModelTests: XCTestCase {
    var viewModel: UniversitiesViewModel!
    var mockChapterService: MockChapterService!
    
    override func setUp() {
        super.setUp()
        mockChapterService = MockChapterService()
        viewModel = UniversitiesViewModel(chapterService: mockChapterService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockChapterService = nil
        super.tearDown()
    }
    
    func testFilteredUniversities_NoFilter() {
        let universities = viewModel.filteredUniversities
        
        XCTAssertEqual(universities.count, 3)
        XCTAssertTrue(viewModel.hasUniversities)
    }
    
    func testFilteredUniversities_StateFilter() {
        viewModel.selectedState = "California"
        
        let universities = viewModel.filteredUniversities
        
        XCTAssertEqual(universities.count, 1)
        XCTAssertEqual(universities.first?.state, "California")
    }
    
    func testFilteredUniversities_ChapterFilter() {
        viewModel.showOnlyWithChapters = true
        
        let universities = viewModel.filteredUniversities
        
        XCTAssertEqual(universities.count, 2)
        XCTAssertTrue(universities.allSatisfy { $0.hasChapter })
    }
    
    func testFilteredUniversities_SearchText() {
        viewModel.searchText = "MIT"
        
        let universities = viewModel.filteredUniversities
        
        XCTAssertEqual(universities.count, 1)
        XCTAssertEqual(universities.first?.name, "MIT")
    }
    
    func testFilteredUniversities_Combined() {
        viewModel.selectedState = "California"
        viewModel.showOnlyWithChapters = true
        viewModel.searchText = "UCLA"
        
        let universities = viewModel.filteredUniversities
        
        XCTAssertEqual(universities.count, 1)
        XCTAssertEqual(universities.first?.name, "UCLA")
        XCTAssertTrue(universities.first?.hasChapter ?? false)
    }
    
    func testGroupedUniversities() {
        let grouped = viewModel.groupedUniversities
        
        XCTAssertTrue(grouped.keys.contains("California"))
        XCTAssertTrue(grouped.keys.contains("Texas"))
        XCTAssertTrue(grouped.keys.contains("Massachusetts"))
    }
    
    func testSortedStateKeys() {
        let keys = viewModel.sortedStateKeys
        
        XCTAssertTrue(keys.sorted() == keys) // Should be sorted
    }
    
    func testUniversitiesInState() {
        let californiaUniversities = viewModel.universitiesInState("California")
        
        XCTAssertEqual(californiaUniversities.count, 1)
        XCTAssertEqual(californiaUniversities.first?.name, "UCLA")
    }
    
    func testClearFilters() {
        viewModel.searchText = "Test"
        viewModel.selectedState = "California"
        viewModel.showOnlyWithChapters = true
        
        viewModel.clearFilters()
        
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.selectedState, "All States")
        XCTAssertFalse(viewModel.showOnlyWithChapters)
    }
}
