//
//  MockChapterService.swift
//  SwiftChapterUSA Finder Tests
//
//  Created on November 15, 2025.
//

import Foundation
@testable import SwiftChapterUSA_finder

class MockChapterService: ChapterServiceProtocol {
    var chapters: [Chapter] = []
    var universities: [University] = []
    var blogPosts: [BlogPost] = []
    
    var addChapterCalled = false
    var addBlogPostCalled = false
    var addReplyToPostCalled = false
    
    init() {
        setupMockData()
    }
    
    private func setupMockData() {
        chapters = [
            Chapter(
                name: "Test Chapter 1",
                state: "California",
                city: "Los Angeles",
                university: "UCLA",
                presidentName: "John Doe",
                contactEmail: "john@example.com",
                description: "Test chapter",
                memberCount: 50,
                dateEstablished: Date()
            ),
            Chapter(
                name: "Test Chapter 2",
                state: "Texas",
                city: "Austin",
                university: "UT Austin",
                presidentName: "Jane Smith",
                contactEmail: "jane@example.com",
                description: "Another test chapter",
                memberCount: 75,
                dateEstablished: Date()
            )
        ]
        
        universities = [
            University(name: "UCLA", state: "California", city: "Los Angeles", hasChapter: true, studentPopulation: 45000),
            University(name: "UT Austin", state: "Texas", city: "Austin", hasChapter: true, studentPopulation: 52000),
            University(name: "MIT", state: "Massachusetts", city: "Cambridge", hasChapter: false, studentPopulation: 12000)
        ]
        
        blogPosts = [
            BlogPost(
                authorId: UUID(),
                authorName: "Test User",
                content: "Test post content",
                chapterId: chapters.first?.id
            )
        ]
    }
    
    func chaptersInState(_ state: String) -> [Chapter] {
        chapters.filter { $0.state == state }
    }
    
    func universitiesInState(_ state: String) -> [University] {
        universities.filter { $0.state == state }
    }
    
    func searchChapters(query: String) -> [Chapter] {
        chapters.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.city.localizedCaseInsensitiveContains(query) ||
            $0.state.localizedCaseInsensitiveContains(query)
        }
    }
    
    func addChapter(_ chapter: Chapter) {
        addChapterCalled = true
        chapters.append(chapter)
    }
    
    func addBlogPost(_ post: BlogPost) {
        addBlogPostCalled = true
        blogPosts.insert(post, at: 0)
    }
    
    func addReplyToPost(postId: UUID, reply: BlogPost.Reply) {
        addReplyToPostCalled = true
        if let index = blogPosts.firstIndex(where: { $0.id == postId }) {
            blogPosts[index].replies.append(reply)
        }
    }
}
