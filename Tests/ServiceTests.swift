//
//  ServiceTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
import Combine
@testable import SwiftChapterUSA_finder

class AuthenticationManagerTests: XCTestCase {
    var authManager: AuthenticationManager!
    
    override func setUp() {
        super.setUp()
        authManager = AuthenticationManager()
        // Clear UserDefaults
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
    
    override func tearDown() {
        authManager = nil
        UserDefaults.standard.removeObject(forKey: "currentUser")
        super.tearDown()
    }
    
    func testRegister() {
        authManager.register(
            email: "test@example.com",
            password: "password123",
            firstName: "John",
            lastName: "Doe",
            state: "California",
            university: "UCLA"
        )
        
        XCTAssertTrue(authManager.isAuthenticated)
        XCTAssertNotNil(authManager.currentUser)
        XCTAssertEqual(authManager.currentUser?.email, "test@example.com")
        XCTAssertEqual(authManager.currentUser?.firstName, "John")
    }
    
    func testLogin_Success() {
        // First register
        authManager.register(
            email: "test@example.com",
            password: "password123",
            firstName: "John",
            lastName: "Doe",
            state: "California",
            university: nil
        )
        
        // Logout
        authManager.logout()
        XCTAssertFalse(authManager.isAuthenticated)
        
        // Try login
        authManager.login(email: "test@example.com", password: "password123")
        
        XCTAssertTrue(authManager.isAuthenticated)
        XCTAssertNotNil(authManager.currentUser)
        XCTAssertNil(authManager.errorMessage)
    }
    
    func testLogin_Failure() {
        authManager.login(email: "nonexistent@example.com", password: "wrongpassword")
        
        XCTAssertFalse(authManager.isAuthenticated)
        XCTAssertNil(authManager.currentUser)
        XCTAssertNotNil(authManager.errorMessage)
    }
    
    func testLogout() {
        authManager.register(
            email: "test@example.com",
            password: "password123",
            firstName: "John",
            lastName: "Doe",
            state: "California",
            university: nil
        )
        
        XCTAssertTrue(authManager.isAuthenticated)
        
        authManager.logout()
        
        XCTAssertFalse(authManager.isAuthenticated)
        XCTAssertNil(authManager.currentUser)
    }
    
    func testUpdateUser() {
        var user = User(
            email: "test@example.com",
            firstName: "John",
            lastName: "Doe",
            state: "California"
        )
        
        authManager.currentUser = user
        authManager.isAuthenticated = true
        
        user.firstName = "Jane"
        authManager.updateUser(user)
        
        XCTAssertEqual(authManager.currentUser?.firstName, "Jane")
    }
}

class ChapterManagerTests: XCTestCase {
    var chapterManager: ChapterManager!
    
    override func setUp() {
        super.setUp()
        chapterManager = ChapterManager()
    }
    
    override func tearDown() {
        chapterManager = nil
        super.tearDown()
    }
    
    func testLoadInitialData() {
        XCTAssertFalse(chapterManager.chapters.isEmpty)
        XCTAssertFalse(chapterManager.universities.isEmpty)
        XCTAssertGreaterThanOrEqual(chapterManager.chapters.count, 50)
    }
    
    func testChaptersInState() {
        let californiaChapters = chapterManager.chaptersInState("California")
        
        XCTAssertFalse(californiaChapters.isEmpty)
        XCTAssertTrue(californiaChapters.allSatisfy { $0.state == "California" })
    }
    
    func testUniversitiesInState() {
        let californiaUniversities = chapterManager.universitiesInState("California")
        
        XCTAssertFalse(californiaUniversities.isEmpty)
        XCTAssertTrue(californiaUniversities.allSatisfy { $0.state == "California" })
    }
    
    func testSearchChapters() {
        let results = chapterManager.searchChapters(query: "UCLA")
        
        XCTAssertFalse(results.isEmpty)
        XCTAssertTrue(results.contains { chapter in
            chapter.name.contains("UCLA") ||
            chapter.city.contains("UCLA") ||
            (chapter.university?.contains("UCLA") ?? false)
        })
    }
    
    func testSearchChapters_EmptyQuery() {
        let results = chapterManager.searchChapters(query: "")
        
        XCTAssertEqual(results.count, chapterManager.chapters.count)
    }
    
    func testAddChapter() {
        let initialCount = chapterManager.chapters.count
        
        let newChapter = Chapter(
            name: "Test Chapter",
            state: "Massachusetts",
            city: "Boston",
            presidentName: "Test President",
            contactEmail: "test@example.com",
            description: "Test description",
            memberCount: 10,
            dateEstablished: Date()
        )
        
        chapterManager.addChapter(newChapter)
        
        XCTAssertEqual(chapterManager.chapters.count, initialCount + 1)
        XCTAssertTrue(chapterManager.chapters.contains { $0.id == newChapter.id })
    }
    
    func testAddBlogPost() {
        let post = BlogPost(
            authorId: UUID(),
            authorName: "Test User",
            content: "Test post content"
        )
        
        chapterManager.addBlogPost(post)
        
        XCTAssertEqual(chapterManager.blogPosts.count, 1)
        XCTAssertEqual(chapterManager.blogPosts.first?.id, post.id)
    }
    
    func testAddReplyToPost() {
        let post = BlogPost(
            authorId: UUID(),
            authorName: "Test User",
            content: "Test post"
        )
        
        chapterManager.addBlogPost(post)
        
        let reply = BlogPost.Reply(
            authorId: UUID(),
            authorName: "Reply User",
            content: "Test reply"
        )
        
        chapterManager.addReplyToPost(postId: post.id, reply: reply)
        
        XCTAssertEqual(chapterManager.blogPosts.first?.replies.count, 1)
        XCTAssertEqual(chapterManager.blogPosts.first?.replies.first?.content, "Test reply")
    }
}
