//
//  UniversitiesViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class UniversitiesViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedState = "All States"
    @Published var showOnlyWithChapters = false
    
    private let chapterService: ChapterServiceProtocol
    
    init(chapterService: ChapterServiceProtocol) {
        self.chapterService = chapterService
    }
    
    var filteredUniversities: [University] {
        var universities = chapterService.universities
        
        if selectedState != "All States" {
            universities = universities.filter { $0.state == selectedState }
        }
        
        if showOnlyWithChapters {
            universities = universities.filter { $0.hasChapter }
        }
        
        if !searchText.isEmpty {
            universities = universities.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.city.localizedCaseInsensitiveContains(searchText) ||
                $0.state.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return universities.sorted { $0.state < $1.state }
    }
    
    var groupedUniversities: [String: [University]] {
        Dictionary(grouping: filteredUniversities) { $0.state }
    }
    
    var sortedStateKeys: [String] {
        groupedUniversities.keys.sorted()
    }
    
    var hasUniversities: Bool {
        !filteredUniversities.isEmpty
    }
    
    func universitiesInState(_ state: String) -> [University] {
        chapterService.universitiesInState(state)
    }
    
    func clearFilters() {
        searchText = ""
        selectedState = "All States"
        showOnlyWithChapters = false
    }
}
