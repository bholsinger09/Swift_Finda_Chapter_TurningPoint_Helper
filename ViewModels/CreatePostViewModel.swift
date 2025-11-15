//
//  CreatePostViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class CreatePostViewModel: ObservableObject {
    @Published var postContent = ""
    @Published var postToChapter = false
    
    private let chapterService: ChapterServiceProtocol
    private let authService: AuthenticationServiceProtocol
    
    init(chapterService: ChapterServiceProtocol, authService: AuthenticationServiceProtocol) {
        self.chapterService = chapterService
        self.authService = authService
    }
    
    var isFormValid: Bool {
        !postContent.isEmpty
    }
    
    func createPost() -> Bool {
        guard let user = authService.currentUser, isFormValid else { return false }
        
        let chapterId = postToChapter ? user.chapterId : nil
        
        let newPost = BlogPost(
            authorId: user.id,
            authorName: user.fullName,
            content: postContent,
            chapterId: chapterId
        )
        
        chapterService.addBlogPost(newPost)
        return true
    }
    
    func clearForm() {
        postContent = ""
        postToChapter = false
    }
}
