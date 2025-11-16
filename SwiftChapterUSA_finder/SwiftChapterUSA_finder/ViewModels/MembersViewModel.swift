//
//  MembersViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class MembersViewModel: ObservableObject {
    private let chapterService: ChapterServiceProtocol
    private let authService: AuthenticationServiceProtocol
    
    init(chapterService: ChapterServiceProtocol, authService: AuthenticationServiceProtocol) {
        self.chapterService = chapterService
        self.authService = authService
    }
    
    var currentUser: User? {
        authService.currentUser
    }
    
    var userName: String {
        currentUser?.fullName ?? "Member"
    }
    
    var isMember: Bool {
        currentUser?.isMember ?? false
    }
    
    var userChapter: Chapter? {
        if let chapterId = currentUser?.chapterId {
            return chapterService.chapters.first { $0.id == chapterId }
        } else if let userState = currentUser?.state {
            return chapterService.chaptersInState(userState).first
        }
        return nil
    }
    
    var nearbyChapters: [Chapter] {
        guard let state = currentUser?.state else { return [] }
        return Array(chapterService.chaptersInState(state).prefix(3))
    }
    
    var hasChapter: Bool {
        userChapter != nil
    }
}
