//
//  CreateChapterViewModel.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import Foundation
import Combine

class CreateChapterViewModel: ObservableObject {
    @Published var chapterName = ""
    @Published var selectedState = "Alabama"
    @Published var city = ""
    @Published var university = ""
    @Published var presidentName = ""
    @Published var contactEmail = ""
    @Published var phoneNumber = ""
    @Published var description = ""
    @Published var meetingLocation = ""
    @Published var meetingSchedule = ""
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    private let chapterService: ChapterServiceProtocol
    
    init(chapterService: ChapterServiceProtocol) {
        self.chapterService = chapterService
    }
    
    var isFormValid: Bool {
        !chapterName.isEmpty &&
        !city.isEmpty &&
        !presidentName.isEmpty &&
        !contactEmail.isEmpty &&
        contactEmail.contains("@") &&
        !description.isEmpty
    }
    
    func createChapter() -> Bool {
        guard isFormValid else { return false }
        
        let newChapter = Chapter(
            name: chapterName,
            state: selectedState,
            city: city,
            university: university.isEmpty ? nil : university,
            presidentName: presidentName,
            contactEmail: contactEmail,
            phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
            description: description,
            memberCount: 1,
            meetingLocation: meetingLocation.isEmpty ? nil : meetingLocation,
            meetingSchedule: meetingSchedule.isEmpty ? nil : meetingSchedule,
            dateEstablished: Date(),
            isActive: true
        )
        
        chapterService.addChapter(newChapter)
        alertMessage = "Your chapter '\(chapterName)' has been successfully created!"
        showingAlert = true
        return true
    }
    
    func clearForm() {
        chapterName = ""
        city = ""
        university = ""
        presidentName = ""
        contactEmail = ""
        phoneNumber = ""
        description = ""
        meetingLocation = ""
        meetingSchedule = ""
    }
}
