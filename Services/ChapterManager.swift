//
//  ChapterManager.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class ChapterManager: ObservableObject, ChapterServiceProtocol {
    @Published var chapters: [Chapter] = []
    @Published var universities: [University] = []
    @Published var blogPosts: [BlogPost] = []
    
    init() {
        loadInitialData()
    }
    
    func loadInitialData() {
        chapters = ChapterData.sampleChapters
        universities = UniversityData.sampleUniversities
        blogPosts = []
    }
    
    func chaptersInState(_ state: String) -> [Chapter] {
        chapters.filter { $0.state == state }
    }
    
    func universitiesInState(_ state: String) -> [University] {
        universities.filter { $0.state == state }
    }
    
    func searchChapters(query: String) -> [Chapter] {
        if query.isEmpty {
            return chapters
        }
        return chapters.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.city.localizedCaseInsensitiveContains(query) ||
            $0.state.localizedCaseInsensitiveContains(query) ||
            ($0.university?.localizedCaseInsensitiveContains(query) ?? false)
        }
    }
    
    func addChapter(_ chapter: Chapter) {
        chapters.append(chapter)
        saveChapters()
    }
    
    func addBlogPost(_ post: BlogPost) {
        blogPosts.insert(post, at: 0)
        saveBlogPosts()
    }
    
    func addReplyToPost(postId: UUID, reply: BlogPost.Reply) {
        if let index = blogPosts.firstIndex(where: { $0.id == postId }) {
            blogPosts[index].replies.append(reply)
            saveBlogPosts()
        }
    }
    
    private func saveChapters() {
        if let encoded = try? JSONEncoder().encode(chapters) {
            UserDefaults.standard.set(encoded, forKey: "chapters")
        }
    }
    
    private func saveBlogPosts() {
        if let encoded = try? JSONEncoder().encode(blogPosts) {
            UserDefaults.standard.set(encoded, forKey: "blogPosts")
        }
    }
}
