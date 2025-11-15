//
//  BlogPost.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation

struct BlogPost: Identifiable, Codable {
    var id: UUID = UUID()
    var authorId: UUID
    var authorName: String
    var content: String
    var timestamp: Date = Date()
    var likes: Int = 0
    var replies: [Reply] = []
    var chapterId: UUID?
    
    struct Reply: Identifiable, Codable {
        var id: UUID = UUID()
        var authorId: UUID
        var authorName: String
        var content: String
        var timestamp: Date = Date()
    }
}
