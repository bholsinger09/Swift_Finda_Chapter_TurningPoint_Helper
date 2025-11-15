//
//  ChaptersViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class ChaptersViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedState = "All States"
    @Published var showingCreateChapter = false
    
    private let chapterService: ChapterServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(chapterService: ChapterServiceProtocol) {
        self.chapterService = chapterService
    }
    
    var filteredChapters: [Chapter] {
        var chapters = chapterService.chapters
        
        if selectedState != "All States" {
            chapters = chapters.filter { $0.state == selectedState }
        }
        
        if !searchText.isEmpty {
            chapters = chapterService.searchChapters(query: searchText)
            if selectedState != "All States" {
                chapters = chapters.filter { $0.state == selectedState }
            }
        }
        
        return chapters.sorted { $0.state < $1.state }
    }
    
    var hasChapters: Bool {
        !filteredChapters.isEmpty
    }
    
    func clearSearch() {
        searchText = ""
        selectedState = "All States"
    }
    
    func chaptersCount: Int {
        filteredChapters.count
    }
}
