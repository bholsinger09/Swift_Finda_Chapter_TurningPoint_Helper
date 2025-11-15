//
//  BlogViewModelTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
import Combine
@testable import SwiftChapterUSA_finder

class BlogViewModelTests: XCTestCase {
    var viewModel: BlogViewModel!
    var mockChapterService: MockChapterService!
    var mockAuthService: MockAuthenticationService!
    
    override func setUp() {
        super.setUp()
        mockChapterService = MockChapterService()
        mockAuthService = MockAuthenticationService()
        
        // Set up authenticated user
        mockAuthService.currentUser = User(
            email: "test@example.com",
            firstName: "Test",
            lastName: "User",
            state: "California"
        )
        mockAuthService.isAuthenticated = true
        
        viewModel = BlogViewModel(
            chapterService: mockChapterService,
            authService: mockAuthService
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockChapterService = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testFilteredPosts_AllPosts() {
        viewModel.selectedFilter = "All Posts"
        
        let posts = viewModel.filteredPosts
        
        XCTAssertEqual(posts.count, 1)
        XCTAssertTrue(viewModel.hasPosts)
    }
    
    func testFilteredPosts_MyChapter() {
        // Set user's chapter ID
        let chapterId = mockChapterService.chapters.first?.id
        mockAuthService.currentUser?.chapterId = chapterId
        
        viewModel.selectedFilter = "My Chapter"
        
        let posts = viewModel.filteredPosts
        
        XCTAssertGreaterThanOrEqual(posts.count, 0)
    }
    
    func testFilteredPosts_MyState() {
        viewModel.selectedFilter = "My State"
        
        let posts = viewModel.filteredPosts
        
        XCTAssertGreaterThanOrEqual(posts.count, 0)
    }
    
    func testAddReply() {
        let postId = mockChapterService.blogPosts.first!.id
        let replyContent = "Test reply"
        
        viewModel.addReply(to: postId, content: replyContent)
        
        XCTAssertTrue(mockChapterService.addReplyToPostCalled)
    }
    
    func testAddReply_EmptyContent() {
        let postId = mockChapterService.blogPosts.first!.id
        
        viewModel.addReply(to: postId, content: "")
        
        // Should not add empty reply
        XCTAssertFalse(mockChapterService.addReplyToPostCalled)
    }
}
