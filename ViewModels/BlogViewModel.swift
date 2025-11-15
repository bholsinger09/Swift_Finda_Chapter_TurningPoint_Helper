//
//  BlogViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class BlogViewModel: ObservableObject {
    @Published var selectedFilter = "All Posts"
    @Published var showingCreatePost = false
    
    private let chapterService: ChapterServiceProtocol
    private let authService: AuthenticationServiceProtocol
    
    let filters = ["All Posts", "My Chapter", "My State"]
    
    init(chapterService: ChapterServiceProtocol, authService: AuthenticationServiceProtocol) {
        self.chapterService = chapterService
        self.authService = authService
    }
    
    var filteredPosts: [BlogPost] {
        switch selectedFilter {
        case "My Chapter":
            if let chapterId = authService.currentUser?.chapterId {
                return chapterService.blogPosts.filter { $0.chapterId == chapterId }
            }
            return []
        case "My State":
            if let userState = authService.currentUser?.state {
                let stateChapterIds = chapterService.chaptersInState(userState).map { $0.id }
                return chapterService.blogPosts.filter { post in
                    if let chapterId = post.chapterId {
                        return stateChapterIds.contains(chapterId)
                    }
                    return true
                }
            }
            return chapterService.blogPosts
        default:
            return chapterService.blogPosts
        }
    }
    
    var hasPosts: Bool {
        !filteredPosts.isEmpty
    }
    
    func addReply(to postId: UUID, content: String) {
        guard let user = authService.currentUser, !content.isEmpty else { return }
        
        let reply = BlogPost.Reply(
            authorId: user.id,
            authorName: user.fullName,
            content: content
        )
        
        chapterService.addReplyToPost(postId: postId, reply: reply)
    }
}
