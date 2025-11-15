//
//  ModelTests.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import XCTest
@testable import SwiftChapterUSA_finder

class ModelTests: XCTestCase {
    
    // MARK: - User Model Tests
    
    func testUserInitialization() {
        let user = User(
            email: "test@example.com",
            firstName: "John",
            lastName: "Doe",
            state: "California",
            university: "UCLA"
        )
        
        XCTAssertEqual(user.email, "test@example.com")
        XCTAssertEqual(user.firstName, "John")
        XCTAssertEqual(user.lastName, "Doe")
        XCTAssertEqual(user.state, "California")
        XCTAssertEqual(user.university, "UCLA")
        XCTAssertEqual(user.fullName, "John Doe")
        XCTAssertFalse(user.isMember)
    }
    
    func testUserFullName() {
        let user = User(
            email: "test@example.com",
            firstName: "Jane",
            lastName: "Smith",
            state: "Texas"
        )
        
        XCTAssertEqual(user.fullName, "Jane Smith")
    }
    
    func testUserCodable() throws {
        let user = User(
            email: "test@example.com",
            firstName: "John",
            lastName: "Doe",
            state: "California"
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        
        let decoder = JSONDecoder()
        let decodedUser = try decoder.decode(User.self, from: data)
        
        XCTAssertEqual(user.id, decodedUser.id)
        XCTAssertEqual(user.email, decodedUser.email)
        XCTAssertEqual(user.firstName, decodedUser.firstName)
        XCTAssertEqual(user.lastName, decodedUser.lastName)
    }
    
    // MARK: - Chapter Model Tests
    
    func testChapterInitialization() {
        let chapter = Chapter(
            name: "UCLA Chapter",
            state: "California",
            city: "Los Angeles",
            university: "UCLA",
            presidentName: "John Doe",
            contactEmail: "john@example.com",
            description: "Test chapter",
            memberCount: 50,
            dateEstablished: Date()
        )
        
        XCTAssertEqual(chapter.name, "UCLA Chapter")
        XCTAssertEqual(chapter.state, "California")
        XCTAssertEqual(chapter.city, "Los Angeles")
        XCTAssertEqual(chapter.university, "UCLA")
        XCTAssertEqual(chapter.presidentName, "John Doe")
        XCTAssertEqual(chapter.memberCount, 50)
        XCTAssertTrue(chapter.isActive)
    }
    
    func testChapterDisplayName() {
        let chapterWithUniversity = Chapter(
            name: "Test",
            state: "California",
            city: "Los Angeles",
            university: "UCLA",
            presidentName: "John",
            contactEmail: "john@example.com",
            description: "Test",
            memberCount: 50,
            dateEstablished: Date()
        )
        
        XCTAssertEqual(chapterWithUniversity.displayName, "UCLA Chapter")
        
        let chapterWithoutUniversity = Chapter(
            name: "Test",
            state: "California",
            city: "Los Angeles",
            presidentName: "John",
            contactEmail: "john@example.com",
            description: "Test",
            memberCount: 50,
            dateEstablished: Date()
        )
        
        XCTAssertEqual(chapterWithoutUniversity.displayName, "Los Angeles, California Chapter")
    }
    
    func testChapterCodable() throws {
        let chapter = Chapter(
            name: "UCLA Chapter",
            state: "California",
            city: "Los Angeles",
            university: "UCLA",
            presidentName: "John Doe",
            contactEmail: "john@example.com",
            description: "Test chapter",
            memberCount: 50,
            dateEstablished: Date()
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(chapter)
        
        let decoder = JSONDecoder()
        let decodedChapter = try decoder.decode(Chapter.self, from: data)
        
        XCTAssertEqual(chapter.id, decodedChapter.id)
        XCTAssertEqual(chapter.name, decodedChapter.name)
        XCTAssertEqual(chapter.state, decodedChapter.state)
    }
    
    // MARK: - University Model Tests
    
    func testUniversityInitialization() {
        let university = University(
            name: "UCLA",
            state: "California",
            city: "Los Angeles",
            hasChapter: true,
            studentPopulation: 45000
        )
        
        XCTAssertEqual(university.name, "UCLA")
        XCTAssertEqual(university.state, "California")
        XCTAssertEqual(university.city, "Los Angeles")
        XCTAssertTrue(university.hasChapter)
        XCTAssertEqual(university.studentPopulation, 45000)
    }
    
    func testUniversityDisplayLocation() {
        let university = University(
            name: "UCLA",
            state: "California",
            city: "Los Angeles",
            hasChapter: true
        )
        
        XCTAssertEqual(university.displayLocation, "Los Angeles, California")
    }
    
    // MARK: - BlogPost Model Tests
    
    func testBlogPostInitialization() {
        let userId = UUID()
        let post = BlogPost(
            authorId: userId,
            authorName: "John Doe",
            content: "Test post content"
        )
        
        XCTAssertEqual(post.authorId, userId)
        XCTAssertEqual(post.authorName, "John Doe")
        XCTAssertEqual(post.content, "Test post content")
        XCTAssertEqual(post.likes, 0)
        XCTAssertTrue(post.replies.isEmpty)
    }
    
    func testBlogPostReply() {
        let replyId = UUID()
        let reply = BlogPost.Reply(
            authorId: replyId,
            authorName: "Jane Smith",
            content: "Reply content"
        )
        
        XCTAssertEqual(reply.authorId, replyId)
        XCTAssertEqual(reply.authorName, "Jane Smith")
        XCTAssertEqual(reply.content, "Reply content")
    }
    
    func testBlogPostCodable() throws {
        let post = BlogPost(
            authorId: UUID(),
            authorName: "John Doe",
            content: "Test post"
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(post)
        
        let decoder = JSONDecoder()
        let decodedPost = try decoder.decode(BlogPost.self, from: data)
        
        XCTAssertEqual(post.id, decodedPost.id)
        XCTAssertEqual(post.content, decodedPost.content)
        XCTAssertEqual(post.authorName, decodedPost.authorName)
    }
}
