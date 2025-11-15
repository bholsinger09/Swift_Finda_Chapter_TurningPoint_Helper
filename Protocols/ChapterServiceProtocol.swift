//
//  ChapterServiceProtocol.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation

protocol ChapterServiceProtocol: AnyObject {
    var chapters: [Chapter] { get }
    var universities: [University] { get }
    var blogPosts: [BlogPost] { get }
    
    func chaptersInState(_ state: String) -> [Chapter]
    func universitiesInState(_ state: String) -> [University]
    func searchChapters(query: String) -> [Chapter]
    func addChapter(_ chapter: Chapter)
    func addBlogPost(_ post: BlogPost)
    func addReplyToPost(postId: UUID, reply: BlogPost.Reply)
}
